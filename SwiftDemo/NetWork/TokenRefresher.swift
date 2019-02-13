//
// TokenRefresher.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/12. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import RxSwift
import Moya

class TokenRefresher{
    static let shared = TokenRefresher()
    public var token:String!
    
    private var publishSubject: PublishSubject<Void>
    private var tokenRequest: Observable<Void>
    private var isRefreshing = false
    private let provider = MoyaProvider<LoginService>(plugins:[NetworkLoggerPlugin(verbose:true)]);
    
    private init(){
        publishSubject = PublishSubject<Void>()
        tokenRequest = provider.rx.request(.LoginRequest(username: "113", password: "113")).asObservable()
            .flatMap({ (response) -> Observable<Void> in
                TokenRefresher.shared.isRefreshing = false
                if let jsonResult = try? JSONDecoder().decode(ModelResponse<String>.self, from: response.data){
                    if(jsonResult.code == 0){
                        TokenRefresher.shared.token = "1111"
                        return Observable.just(())
                    }
                }
                throw NetWorkError.TokenRefreshFaild
            }).catchError({ (Error) -> Observable<()> in
                TokenRefresher.shared.isRefreshing = false
                return Observable.just(())
            })
        token = nil
    }
    
    
    public func refreshToken() -> Observable<Void>{
        if(!isRefreshing){
            token = nil
            tokenRequest.subscribe(publishSubject.asObserver())
//            publishSubject.asObserver().subscribe(tokenRequest)
        }
        return publishSubject
    }
}
