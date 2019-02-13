//
// NetWorkBusnissViewModel.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/12. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import RxSwift
import RxCocoa
import Moya
import Result

class NetWorkBusnissViewModel{
    // MARK: input
    var getNationTapObserver : Observable<Void>{
        set{
            newValue.asObservable().subscribe(onNext:{[weak self] _ in
                self?.getNationList()
            })
            //            self.setupLoginRequet(loginTaps: newValue)
        }
        get{
            return self.getNationTapObserver
        }
    }
    
    // MARK:output
    private let naitonRequestSubject = PublishSubject<Result<String>>()
    private let signingIn = ActivityIndicator()
    
    struct Output {
        let nationListObservable: Observable<Result<String>>
    }
    let output: Output
    

    //MARK:- private var
    private let provider = MoyaProvider<CommonService>(plugins:[NetworkLoggerPlugin(verbose:true)]);
    private let disposeBag = DisposeBag()
    init() {
        output = Output(nationListObservable: naitonRequestSubject.asObservable())
    }
    
    func getNationList() {
        provider.rx.request(.getNationList()).asObservable().toJSON(String.self).subscribe {[weak self] (event) in
            switch event{
            case .next(let response):
                self?.naitonRequestSubject.onNext(Result<String>.success(response))
            case .error:
                self?.naitonRequestSubject.onNext(Result.failure(NetWorkError.JSONDecode))
            default:
                break
            }
            }.disposed(by: disposeBag)
    }
    
}
