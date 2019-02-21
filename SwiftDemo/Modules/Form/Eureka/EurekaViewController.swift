//
// EurekaViewController.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/20. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import UIKit
import Eureka

class EurekaViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Eureka"
        form +++ Section("Section1")
            <<< TextRow(){ row in
                row.tag = "address"
                row.title = "地址"
                row.placeholder = "Enter address here"
            }
            <<< PhoneRow(){
                $0.tag = "phone"
                $0.title = "电话"
                $0.placeholder = "Enter numbers here"
            }
            +++ Section("Section2")
            <<< DateRow(){
                
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            
        }
            +++ ButtonRow(){
                $0.title = "确定"
                $0.tag = "confirm"
                }.onCellSelection({ (row, row1) in
                   print( self.form.values())
                })
        
    }
}

