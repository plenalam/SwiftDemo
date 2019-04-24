//
// CommonService.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/12. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import Moya

enum CommonService{
    case getNationList
}

extension CommonService : TargetType{
    var baseURL : URL{ return URL(string: "http://192.168.26.132:8063")!};
    var path : String{
        switch self {
        case .getNationList:
            return "/common/getNationList";
        }
    }
    var method : Moya.Method{
        switch self {
        case .getNationList:
            return .get
        default:
            return .get
        }
    }
    
    
    var task : Task{
        switch self {
        default:
            return .requestPlain;
        }
    }
    
    var sampleData : Data {
        switch self {
        case .getNationList:
            return  Data();
        default:
            return  Data();
        }
    }
    
    var headers: [String:String]?{
        return ["Content-type": "application/json"]
    }
}
