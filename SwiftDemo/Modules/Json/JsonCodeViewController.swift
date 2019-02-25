
//
// JsonCodeViewController.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/20. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import UIKit
import Eureka

class JsonCodeViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Json And Codeable";
        self.setUpForm()
        runTest()
        codeableArrayToJsonStr()
    }
    
    private func runTest(){
        let bean = UserBean()
        bean.address = "123"
        bean.name = UserBean.UserName()
        bean.name?.first = "lam"
        bean.name?.last = "zoe"
        bean.gender = .female
        bean.phone = 123456
        let encoder = JSONEncoder()
        let data = try! encoder.encode(bean)
        let JsonStr = String(data: data, encoding: .utf8)
        form.setValues(["Codeable To JSON String":JsonStr!])
        
        JsonStrToCodeable(input: JsonStr!)
        encodableToDictionary(encodable: bean)
        
        
    }
    
    private func JsonStrToCodeable(input:String){
        let decoder = JSONDecoder()
        guard let bean = try? decoder.decode(UserBean.self, from: input.data(using: .utf8)!) else {
            form.setValues(["Json String To Codeable":"error"])
            return
        }
        form.setValues(["Json String To Codeable":"\(bean)"])
    }
    
    private func encodableToDictionary<T>(encodable: T ) ->() where T : Encodable{
        let data = try? JSONEncoder().encode(encodable)
        guard let dictionary = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {
            form.setValues(["Encodable To Dictionary":"error"])
            return
        }
        form.setValues(["Encodable To Dictionary":"\(dictionary!)"])
        dictionaryToEncodeable(dictionary: dictionary!)
        
    }
    
    private func dictionaryToEncodeable(dictionary:Dictionary<String,Any>){
        let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        guard let bean = try? JSONDecoder().decode(UserBean.self, from: data!) else{
            form.setValues(["Dictionary To Encodable":"error"])
            return
        }
        form.setValues(["Dictionary To Encodable":"\(bean)"])
    }
    
    private func codeableArrayToJsonStr(){
        let bean = UserBean()
        bean.address = "111"
        bean.name = UserBean.UserName()
        bean.name?.first = "lam"
        bean.name?.last = "zoe"
        bean.gender = .female
        bean.phone = 111111
        let bean2 = UserBean()
        bean2.address = "2222"
        bean2.name = UserBean.UserName()
        bean2.name?.first = "lam"
        bean2.name?.last = "zoe"
        bean2.gender = .female
        bean2.phone = 222222
        let beanArrary = [bean,bean2]
        let encoder = JSONEncoder()
        let data = try! encoder.encode(beanArrary)
        let JsonStr = String(data: data, encoding: .utf8)
        form.setValues(["codable Array To JsonStr":JsonStr!])
        JSONStrToCodeableArray(input: JsonStr!)
        
    }
    
    private func JSONStrToCodeableArray(input:String){
        let decoder = JSONDecoder()
        guard let bean = try? decoder.decode([UserBean].self, from: input.data(using: .utf8)!) else {
            form.setValues(["codable Array To JsonStr":"error"])
            return
        }
        form.setValues(["codable Array To JsonStr":"\(bean)"])
    }
    
    private func setUpForm(){
        form +++ Section("Codeable To JSON String")
            <<< TextAreaRow(){ row in
                row.tag = "Codeable To JSON String"
                row.title = ""
                row.disabled = true
                row.placeholder = "Codeable To JSON String"
            }
            +++ Section("Json String To Codeable")
            <<< TextAreaRow(){ row in
                row.tag = "Json String To Codeable"
                row.title = ""
                row.disabled = true
                row.placeholder = "Json To Codeable"
                
            }
            +++ Section("Encodable To Dictionary")
            <<< TextAreaRow(){ row in
                row.tag = "Encodable To Dictionary"
                row.title = ""
                row.disabled = true
                row.placeholder = "Encodable To Dictionary"
                
            }
            +++ Section("Dictionary To Encodable")
            <<< TextAreaRow(){ row in
                row.tag = "Dictionary To Encodable"
                row.title = ""
                row.disabled = true
                row.placeholder = "Dictionary To Encodable"
                
            }
            +++ Section("codable Array To JsonStr")
            <<< TextAreaRow(){ row in
                row.tag = "codable Array To JsonStr"
                row.title = ""
                row.disabled = true
                row.placeholder = "codable Array To JsonStr"
                
        }
    }
}
