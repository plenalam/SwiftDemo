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
    
    class username: Codable {
        var title : String
        var first : String
        var last : String
    }
    var name: username
    var gender: Gender

    
}

class UserBeanResult : Codable {
    var results : [UserBean]
}
