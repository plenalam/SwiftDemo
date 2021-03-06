//
// IndexViewController.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/1/31. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import UIKit

class IndexViewController : UIViewController,UITableViewDelegate,UITableViewDataSource {
    let datasource = ["Login MVVM",
                      "Json And Codeable",
                      "TableView MMVM",
                      "NetWorkBusiness",
                      "Eureka",
                      "Custom Form",
                      "Where KeyWord",
                      "Custom Eureka",
                      "QRCode"]
    let CELLID = "cellid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    //MARK:TableView
    private func setupTableView(){
        indextableview.delegate = self;
        indextableview.dataSource = self;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(LoginViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(JsonCodeViewController(), animated: true)
        case 2:
            navigationController?.pushViewController(UserTableViewController(), animated: true)
        case 3:
             navigationController?.pushViewController(NetWorkBusinessViewController(), animated: true)
        case 4:
            navigationController?.pushViewController(EurekaViewController(), animated: true)
        case 5:
            navigationController?.pushViewController(CustomFormVC(), animated: true)
        case 6:
            navigationController?.pushViewController(WhereViewController(), animated: true)
        case 7:
            navigationController?.pushViewController(CustomEurekaViewController(), animated: true)
        case 8:
            let qrscanvc = QRCodeScanViewController();
            qrscanvc.scanResultObservable.subscribe(onNext: {[weak self] (result) in
               self?.showAlert(message: result)
            }, onError: {[weak self] (error) in
               self?.showAlert(message: error.localizedDescription)
            })
            navigationController?.pushViewController(qrscanvc, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: CELLID)
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: CELLID)
        }
        cell?.textLabel?.text = datasource[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    
    
    //MARK:UI
    let indextableview = UITableView()
    private func setupUI(){
        self.navigationItem.title = "Index"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(indextableview)
        indextableview.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
        indextableview.tableFooterView = UIView()
    }
    
    private func showAlert(message:String){
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert);
        let alertAction = UIAlertAction(title: "Confirm", style: .default) { action in
        }
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true, completion: {
            
        })
    }
}
