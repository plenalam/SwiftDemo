//
// LPickerCell.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/25. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import UIKit

class LPickerCell : LEditTextCell,UIPickerViewDataSource,UIPickerViewDelegate{
    let pickerView = UIPickerView()
    override  public func setupUI(){
        super.setupUI()
        pickerView.dataSource = self
        pickerView.delegate = self
        editField.inputView = pickerView
    }
    
    func getSourceBean() -> LPicker? {
        return self.bean as? LPicker
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return getSourceBean()?.datasource?.count ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return getSourceBean()?.datasource?[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.editField.text = getSourceBean()?.datasource?[row]
    }
    
}
