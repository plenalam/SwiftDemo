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
    
    
    func settter() {
        
    }
    public init(jsonkey:String){
        self.jsonkey = jsonkey
    }
    
    public init(_ jsonkey:String, _ initializer: @escaping (LBaseCellBean) -> Void = { _ in }) {
        self.jsonkey = jsonkey
        initializer(self)
    }
   
}

