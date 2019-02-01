//
// LoginViewModel.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/1/29. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import RxSwift
import RxCocoa
import Moya

public enum Result<T> {
    case success(T)
    case failure(Swift.Error)
}

class LoginViewModel {
    // MARK: 2 way binding
    let usernameVar = BehaviorRelay<String>(value: "")
    let passwordVar = BehaviorRelay<String>(value: "")
    
    // MARK: input
    var loginTapObserver : Observable<Void>{
        set{
            newValue.asObservable().subscribe(onNext:{[weak self] _ in
                self?.loginRequest()
            })
//            self.setupLoginRequet(loginTaps: newValue)
        }
        get{
            return self.loginTapObserver
        }
    }
    
    // MARK:output
    private let loginTapSubject = PublishSubject<Result<String>>()
    private let signingIn = ActivityIndicator()
    
    struct Output {
        let loginResultObservable: Observable<Result<String>>
        let signingIn : Driver<Bool>
    }
    let output: Output
    
    public func setDelfautValue(){
        usernameVar.accept("admin")
        passwordVar.accept("admin")
    }
    
    //MARK:- private var
    private let provider = MoyaProvider<LoginService>(plugins:[NetworkLoggerPlugin(verbose:true)]);
    init() {
        output = Output(loginResultObservable: loginTapSubject.asObservable(),
                        signingIn:signingIn.asDriver())
    }
    
    private func  setupLoginRequest(){
        loginTapSubject.withLatestFrom(Observable.combineLatest(usernameVar.asObservable(),passwordVar.asObservable()){(username:$0,password:$1)})
            .flatMap { (pair) -> Observable<String> in
                NSLog("\(pair.username)  \(pair.password)")
                return Observable.just("登录成功")
            }
    }
    
    private func setupLoginRequet(loginTaps:Signal<()>){
        let usernameAndPassword = Driver.combineLatest(usernameVar.asDriver(), passwordVar.asDriver()) { (username: $0, password: $1) }
        loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { [weak self] pair -> Driver<Bool> in
                withExtendedLifetime(self){
                return self!.provider.rx.requestWithProgress(.LoginRequest(username: pair.username, password: pair.password))
                    .trackActivity(self!.signingIn)
                    .flatMapLatest({ (progressResponse) -> Observable<Bool> in
                        guard let response = progressResponse.response else {
                            return Observable.just(false)
                        }
                        return Observable.just(true)
                    })
                .asDriver(onErrorJustReturn: false)
                }
                return Driver.just(false)
        }
    }
    
    private func loginRequest(){
        if(usernameVar.value.count < 1){
            return loginTapSubject.onNext(Result.failure(NSError(domain: "1", code: 1, userInfo: [NSLocalizedDescriptionKey:"用户名不能为空"])))
        }
        if(passwordVar.value.count < 1){
            return loginTapSubject.onNext(Result.failure(NSError(domain: "1", code: 1, userInfo: [NSLocalizedDescriptionKey:"密码不能为空"])))
        }

        provider.rx.requestWithProgress(.LoginRequest(username: usernameVar.value, password: passwordVar.value))
            .trackActivity(signingIn)
            .subscribe { [weak self] (event) in
            switch event {
            case .next(let progressResponse):
                guard let response = progressResponse.response else {
                   //  self?.loginTapSubject.onNext(Result.failure(NSError(domain: "1", code: 1, userInfo: [NSLocalizedDescriptionKey:"返回值为空"])))
                    return
                }
                self?.loginTapSubject.onNext(Result<String>.success("\(response.data)"))
            case .error(let error):
                self?.loginTapSubject.onNext(Result.failure(NSError(domain: "1", code: 1, userInfo: [NSLocalizedDescriptionKey:error.localizedDescription])))
            default:
                break
            }
        };
    }

}
