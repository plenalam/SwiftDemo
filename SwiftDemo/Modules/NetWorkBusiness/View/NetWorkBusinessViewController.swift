//
// NetWorkBusinessViewController.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/12. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import UIKit
import RxCocoa

class NetWorkBusinessViewController: UIViewController {
    var viewModel = NetWorkBusnissViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "NetWorkBusiness";
        
        // Do any additional setup after loading the view, typically from a nib.
        self.setUpUI();
        self.setUpBinding();
    }
    
    private func setUpBinding(){
        viewModel.getNationTapObserver = nationBtn.rx.tap.asObservable()
    }
    
    //MARK:UI
    let nationBtn = UIButton(type: .system)
    
    private func setUpUI(){
        self.view?.backgroundColor = UIColor.white;
        nationBtn.setTitle("get nation", for: .normal);
        self.view.addSubview(nationBtn);
        nationBtn.snp.makeConstraints { (make)-> Void in
            make.top.equalTo(self.view.snp_centerYWithinMargins)
            make.leading.equalTo(self.view).offset(20);
            make.trailing.equalTo(self.view).offset(-20);
            
        };
    }
}
