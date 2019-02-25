//
// LBaseCellBean.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/25. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
class LBaseCellBean : Codable,LBaseCellType{
    var title: String?
    var jsonkey: String
    var value: String?
    
    init(jsonKey:String) {
        jsonkey = jsonKey
    }
}
