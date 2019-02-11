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
import RxSwift
import RxCocoa

class UserTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let viewModel = UserTableViewModel()
    var disposeBag = DisposeBag()
    let CELLID = "cellid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupBinding()
        viewModel.startSearch()
    }
    
    //MARK: TableView
    private func setupTableView(){
        userTableview.tableFooterView = UIView()
        userTableview.dataSource = self
        userTableview.delegate = self
        userTableview.register(UserInfoTableCell.self, forCellReuseIdentifier: CELLID)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath)
        let userCell = cell as! UserInfoTableCell
        userCell.bindViewModel(tbean: viewModel.datasource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasource.count
    }
    
    
    //MARK: bindSignal
    private func setupBinding(){
        viewModel.output.searchSubject
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self]result in
                withExtendedLifetime(self){
                    self!.userTableview.reloadData()
                    switch result {
                    case.failure(let error):
                        self!.showAlert(message: error.localizedDescription)
                    default:
                        break
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    
    //MARK:UI
    let userTableview = UITableView()
    private func setupUI(){
        self.navigationItem.title = "RxTableView"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(userTableview)
        userTableview.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
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


