//
// UserTableViewModel.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/1. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import RxSwift
import RxCocoa
import Moya

class UserTableViewModel {
    //MARK: output
    var datasource:[UserBean] = []
    private let searchSubject = PublishSubject<Result<Bool>>()
    private let searchingSignal = ActivityIndicator()
    
    struct Output {
        let searchSubject: Observable<Result<Bool>>
        let searchingSignal : Driver<Bool>
    }
    let output: Output
    
    //MARK:-
    private let provider = MoyaProvider<UserService>(plugins:[NetworkLoggerPlugin(verbose:true)]);
    init() {
         output = Output(searchSubject: searchSubject.asObservable(),
                         searchingSignal: searchingSignal.asDriver())
    }
    
    func startSearch() {
        provider.rx.request(.getUserList(pagesize: 20))
        .trackActivity(searchingSignal)
            .subscribe {  [weak self] (event) in
                switch event{
                case .next(let response):
                    do{
                        let results = try JSONDecoder().decode(UserBeanResult.self, from: response.data)
                         self?.datasource.append(contentsOf: results.results)
                        self?.searchSubject.onNext(Result.success(true))
                    }catch{
                          self?.searchSubject.onNext(Result.failure(NSError(domain: "1", code: 1, userInfo: [NSLocalizedDescriptionKey:"JSON解析错误"])))
                    }
                case .error(let error):
                    self?.searchSubject.onNext(Result.failure(error))
                default:
                    break
                    
                }
        }
    }
    
    
}
