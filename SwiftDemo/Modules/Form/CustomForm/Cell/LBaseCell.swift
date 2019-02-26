//
// LBaseCell.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/25. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import UIKit

class LBaseCell : UITableViewCell{
    var bean : LBaseCellBean!

    public let titleLabel = UILabel();

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.bean = nil
        setupUI()
    }
    
    public func setupUI(){}
    
    public func bindViewModel(pBean:LBaseCellBean){
        self.bean = pBean
    }

}


