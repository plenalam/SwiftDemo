//
// UserTableViewController.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/1/31.
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import UIKit
import SnapKit

class UserTableViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK:UI
    let tableview = UITableView()
    private func setupUI(){
        self.navigationItem.title = "RxTableView"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}


