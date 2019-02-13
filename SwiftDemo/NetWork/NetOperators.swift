//
// NetOperators.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/11. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import RxSwift
import Moya

extension Observable where E: Response {
    func toJSON<T:Codable>(_ type: T.Type) -> Observable<T> {
        return flatMap({ response -> Observable<T> in
            let jsonResult = try! JSONDecoder().decode(ModelResponse<T>.self, from: response.data)
            return Observable<T>.just(jsonResult.data!)
        }).retryWhen { errors -> Observable<Void> in
            var retryCounter = 0;
            return errors.flatMap({ error -> Observable<Void> in
                if let myApiError:NetWorkError = error as? NetWorkError{
                    if (myApiError == NetWorkError.TokenConflict){
                        if(retryCounter > 0){
                            NSLog("retryWhen TokenRefreshFaild")
                            throw NetWorkError.TokenRefreshFaild
                         //   return Observable.error(NetWorkError.TokenRefreshFaild)
                        }
                        retryCounter = retryCounter+1
                        NSLog("retryWhen TokenConflict")
                        return TokenRefresher.shared.refreshToken()
                    }
                }
                throw error
            })
        }
    }
//    func toJSON() -> Observable<BaseJsonResponse> {
//
//        return flatMap({ response -> Observable<BaseJsonResponse> in
//            let jsonResult = try! JSONDecoder().decode(BaseJsonResponse.self, from: response.data)
//            return Observable<BaseJsonResponse>.just(jsonResult)
//        }
//    )}
//
//
//
//     open func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}
