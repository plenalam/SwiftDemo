//
// CustomFormVC.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/25. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import UIKit
import RxCocoa
import RxSwift

class CustomFormVC: UIViewController{
    var disposeBag = DisposeBag()
    
    var customForm = CustomForm()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let bean = LEditText.init(jsonKey: "name")
        bean.title = "姓名"
        bean.value = ""
        customForm.datasource.append(bean)
        let pickBean = LPicker.init(jsonKey: "name")
        pickBean.title = "性别"
        pickBean.value = "男"
        pickBean.datasource = ["男","女"]
        customForm.datasource.append(pickBean)
        customForm.setupTableView()
    }
    
    let but = UIButton(type: .system)
    func setupUI()  {
        self.navigationItem.title = "CustomForm"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(customForm.formTableView)
 
        self.view.addSubview(but)
        but.setTitle("confirm", for: .normal)
        but.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.height.equalTo(48)
        }
        customForm.formTableView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(but.snp_topMargin)
        }
        but.rx.tap
            .subscribe(onNext: { [weak self] _ in
                print("\(String(describing: self?.customForm.getValue()))")
                }
            ).disposed(by: disposeBag);
    }
    
 
}
