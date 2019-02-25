//
// UserInfoTableCell.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/1. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import UIKit
import SnapKit

class  UserInfoTableCell: UITableViewCell {
    private var bean:UserBean?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    func bindViewModel(tbean:UserBean?){
        guard let pbean = tbean else {
            return
        }
        nameLabel.text = "\(String(describing: pbean.name?.first)) \(String(describing: pbean.name?.last))"
        switch pbean.gender {
        case .female:
            genderLabel.text = "男"
        default:
            genderLabel.text = "女"
        }
        bean = pbean
    }
    
    // MARK:UI
    private let nameLabel =  UILabel()
    private let genderLabel = UILabel()
    private let email = UILabel()
    private let headImageView = UIImageView()
    
    private func setupUI(){
        self.contentView.addSubview(headImageView)
        headImageView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().offset(20)
            maker.height.equalTo(60)
            maker.width.equalTo(60)
        }
            self.contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.leading.equalTo(headImageView.snp_trailingMargin).offset(20)
            maker.trailing.equalToSuperview()
        }
         self.contentView.addSubview(genderLabel)
        genderLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(nameLabel)
            maker.top.equalTo(nameLabel.snp_bottomMargin).offset(20)
        }
          self.contentView.addSubview(email)
        email.snp.makeConstraints { (maker) in
            maker.leading.equalTo(nameLabel)
            maker.top.equalTo(genderLabel.snp_bottomMargin).offset(20)
            maker.bottom.equalToSuperview()
        }
        
    }
    
}
