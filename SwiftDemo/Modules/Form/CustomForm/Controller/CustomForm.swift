//
// CustomForm.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/25. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import UIKit

class CustomForm : NSObject, UITableViewDelegate,UITableViewDataSource{
    var datasource:[LBaseCellBean] = []
    
    let formTableView = UITableView();
    
    func setupTableView(){
        formTableView.tableFooterView = UIView()
        formTableView.dataSource = self
        formTableView.delegate = self
        formTableView.register(LEditTextCell.self, forCellReuseIdentifier:String(describing: type(of: LEditTextCell.self)) )
          formTableView.register(LPickerCell.self, forCellReuseIdentifier:String(describing: type(of: LPickerCell
            .self)) )
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bean = datasource[indexPath.row]
        
        switch bean {
        case is LPicker:
            let cell = tableView.dequeueReusableCell(with: LPickerCell.self, for: indexPath)
            cell.bindViewModel(pBean: bean)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(with: LEditTextCell.self, for: indexPath)
            cell.bindViewModel(pBean: bean)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func getValue() -> [String:String?] {
        return Dictionary(uniqueKeysWithValues: datasource.map { ($0.jsonkey, $0.value) })
    }
}
