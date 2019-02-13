//
// NetWorkError.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/11. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation

enum NetWorkError:Error {
    case JSONDecode
    case TokenExpired
    case TokenConflict
    case TokenRefreshFaild
}
