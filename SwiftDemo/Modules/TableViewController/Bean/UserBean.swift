//
// UserBean.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/1. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation


class UserBean : Codable{
    enum Gender : String,Codable{
        case female = "female"
        case male = "male"
    }
    
    struct UserName: Codable {
        var title : String
        var first : String
        var last : String
        
        init() {
            first = ""
            last = ""
            title = ""
        }
    }
    var name: UserName?
    var gender: Gender
    var phone: Int?
    var address: String?

    init() {
        gender = .female
    }
    
}

class UserBeanResult : Codable {
    var results : [UserBean]
}
