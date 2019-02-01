//
// LoginService.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/1/23.
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import Moya

enum LoginService{
    case LoginRequest(username:String,password:String)
}

extension LoginService : TargetType{
    var baseURL : URL{ return URL(string: "http://192.168.26.132:8063")!};
    var path : String{
        switch self {
        case .LoginRequest:
            return "/user/login";
        }
    }
    var method : Moya.Method{
        switch self {
        case .LoginRequest:
            return .post;
        default:
            return .get
        }
    }
    
    
    var task : Task{
        switch self {
        case let .LoginRequest(username: username, password: passwd):
            return .requestParameters(parameters: ["account":username,"password":passwd,"type":1], encoding: URLEncoding.queryString)
        default:
            return .requestPlain;
        }
    }
    
    var sampleData : Data {
        switch self {
        case .LoginRequest:
            return  Data();
        default:
            return  Data();
        }
    }
    
    var headers: [String:String]?{
        return ["Content-type": "application/json"]
    }

}
