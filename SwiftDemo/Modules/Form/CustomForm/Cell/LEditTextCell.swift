//
// LEditTextCell.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/25. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import UIKit

class LEditTextCell : LBaseCell ,UITextFieldDelegate{
    
    public let editField : UITextField = {
        let temp = UITextField()
        return temp
    }()
    
    override  public func setupUI(){
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints({ (maker) in
            maker.leading.equalToSuperview().offset(16)
            maker.height.equalTo(48)
            maker.width.equalTo(70)
        })
        titleLabel.text = "标题"
        contentView.addSubview(editField)
        editField.snp.makeConstraints { (maker) in
            maker.leading.equalTo(titleLabel.snp_trailingMargin).offset(8)
            maker.trailing.equalToSuperview().offset(-16)
            maker.top.bottom.equalToSuperview()
            maker.height.greaterThanOrEqualTo(48)
        }
        editField.delegate = self
    }
    
    override public func bindViewModel(pBean:LBaseCellBean){
        super.bindViewModel(pBean: pBean)
        titleLabel.text = pBean.title ?? "标题"
        editField.placeholder = "请输入\(pBean.title ?? "")"
        editField.text = pBean.value ?? ""
        
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField){
        self.bean.value = textField.text
    }
    
}
