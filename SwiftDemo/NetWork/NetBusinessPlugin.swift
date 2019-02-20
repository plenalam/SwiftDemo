
//
// NetBusinessPlugin.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/19. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import Moya

class NetBusinessPlugin:PluginType{
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest{
        var mutableRequest = request
        mutableRequest.cachePolicy = .useProtocolCachePolicy
        mutableRequest.setValue("token", forHTTPHeaderField: "x-access-token")
        mutableRequest.setValue("ETag", forHTTPHeaderField: "If-None-Match")
        return request;
    }
}
