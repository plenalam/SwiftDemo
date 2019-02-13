//
// BaseJsonResult.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/11. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation

class BaseJsonResponse : Codable{
    var code : Int
    var message : String!
    var serial :Int
}

class ModelResponse<T:Codable> : BaseJsonResponse{
    var data: T?
}
