//
// UserService.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/1/31. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import Moya

enum UserService{
    case getUserList(pagesize:Int)
}

extension UserService : TargetType{
    var baseURL : URL{ return URL(string: "https://api.randomuser.me")!};
    var path : String{
        switch self {
        case .getUserList:
            return "";
        }
    }
    var method : Moya.Method{
        switch self {
        case .getUserList:
            return .post;
        default:
            return .get
        }
    }
    
    
    var task : Task{
        switch self {
        case let .getUserList(pagesize: pagesize):
            return .requestParameters(parameters: ["results":pagesize], encoding: URLEncoding.queryString)
        default:
            return .requestPlain;
        }
    }
    
    var sampleData : Data {
        switch self {
        case .getUserList:
            return  Data();
        default:
            return  Data();
        }
    }
    
    var headers: [String:String]?{
        return ["Content-type": "application/json"]
    }
}
