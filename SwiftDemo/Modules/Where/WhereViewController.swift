//
// WhereViewController.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/3/5. 
// Copyright © 2019 Linzy. All rights reserved.
// ref: https://medium.com/@bestiosdevelope/where-to-be-use-where-37778ac43560
//      https://docs.swift.org/swift-book/ReferenceManual/GenericParametersAndArguments.html
//      https://docs.swift.org/swift-book/LanguageGuide/Generics.html#ID553
//


import Foundation
import UIKit

class WhereViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Where"
        self.view.backgroundColor = UIColor.white
    }
    
    func ifAndGuard()  {
        let webUrl : String? = "https://medium.com"
        if let path = webUrl , path.hasPrefix("https"){
            print("if hasPrefix")
        }else{
            print("if not hasPrefix")
        }
        
        guard let path = webUrl, path.hasSuffix("com") else{
            print("if not hasSuffix")
            return
        }
    }
    
    func switchStatement() {
        let yetPoint = (3,-3)
        switch yetPoint {
        case let(x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let(x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        default:
            print("default")
        }
    }
    
}

// deal error
extension WhereViewController{
    enum ValidationError : Error {
        case RuntimeError(Int)
    }
    func encryptStrign(string: String, password: String) throws {
        if string.count == 0 {
            throw ValidationError.RuntimeError(10)
        }
        else if password.count == 0 {
            throw ValidationError.RuntimeError(11)
        }
    }
    
    func docatch() {
        do {
            try encryptStrign(string: "My secrete", password: "")
        }catch ValidationError.RuntimeError(let errorCode) where errorCode == 10 {
            print("String is empty")
        }
        catch ValidationError.RuntimeError(let errorCode) where errorCode == 11 {
            print("Password is empty") //Matched
        }catch {
            print("catch")
        }
      
    }
}

extension WhereViewController{
    func doSomethin<T>(_ input : T) where T : ExpressibleByStringLiteral {
        print(input)
    }
}

protocol Item {
    init(filename: String)
}

protocol Screen {
    associatedtype ItemType: Item
    associatedtype ChildScreen: Screen where ChildScreen.ItemType == ItemType
    var items: [ItemType] { get set }
    var childScreens: [ChildScreen] { get set }
}

protocol Container {
    associatedtype Contain
    func updateCell(_ data: Contain)
}

class ContainerA : Container{
    typealias Contain = String
    func updateCell(_ data: Contain){
        print(data)
    }
    
}

extension Container where Contain: Equatable {
    func startsWith(_ item: Contain) -> Bool {
        return true
    }
}



extension WhereViewController{
    func testContainer() {
        let container = ContainerA()
        if(container.startsWith("")){
            container.updateCell("2222")
        }
    }
}
