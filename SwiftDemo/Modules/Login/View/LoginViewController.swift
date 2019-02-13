//
// LoginViewController.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/1/23. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import UIKit
import SnapKit
import Moya
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    var viewModel  = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Login";
        // Do any additional setup after loading the view, typically from a nib.
        self.setUpUI();
        self.setUpBinding();
    }
    
    //MARK:UI
    let loginBtn = UIButton(type: .system);
    let logBtn = UIButton(type: .system);
    let twowaybindingBtn = UIButton(type: .system);
    let userNameTextField = UITextField();
    let passWordTextField = UITextField();
    private func setUpUI(){
        self.view?.backgroundColor = UIColor.white;
        
        self.view.addSubview(userNameTextField);
        userNameTextField.placeholder = "username";
        userNameTextField.borderStyle = .bezel;
        userNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(200);
            make.leading.equalTo(self.view).offset(20);
            make.trailing.equalTo(self.view).offset(-20);
            make.height.equalTo(50);
        };
        
        self.view.addSubview(passWordTextField);
        passWordTextField.placeholder = "password";
        passWordTextField.borderStyle = .bezel;
        passWordTextField.isSecureTextEntry = true;
        passWordTextField.accessibilityIdentifier = "passWordTextField";
        passWordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTextField.snp_bottomMargin).offset(20);
            make.leading.equalTo(self.view).offset(20);
            make.trailing.equalTo(self.view).offset(-20);
            make.height.equalTo(50);
        };
        
        
        loginBtn.setTitle("login", for: .normal);
        self.view.addSubview(loginBtn);
        loginBtn.snp.makeConstraints { (make)-> Void in
            make.top.equalTo(passWordTextField.snp_bottomMargin).offset(50);
            make.leading.equalTo(self.view).offset(20);
            make.trailing.equalTo(self.view).offset(-20);
            
        };
        
        logBtn.setTitle("print value", for: .normal);
        self.view.addSubview(logBtn);
        logBtn.snp.makeConstraints { (make)-> Void in
            make.top.equalTo(loginBtn.snp_bottomMargin).offset(20);
            make.leading.equalTo(self.view).offset(20);
            make.trailing.equalTo(self.view).offset(-20);
            
        };
        
        twowaybindingBtn.setTitle("set value by code", for: .normal);
        self.view.addSubview(twowaybindingBtn);
        twowaybindingBtn.snp.makeConstraints { (make)-> Void in
            make.top.equalTo(logBtn.snp_bottomMargin).offset(20);
            make.leading.equalTo(self.view).offset(20);
            make.trailing.equalTo(self.view).offset(-20);
            
        };
        
        
    }
    
    private func setUpBinding(){
        logBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                NSLog("username:\(self?.viewModel.usernameVar.value)");
                NSLog("password:\(self?.viewModel.passwordVar.value)");
                }
            ).disposed(by: disposeBag);
        twowaybindingBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.setDelfautValue()
                }
            ).disposed(by: disposeBag);
        
        viewModel.loginTapObserver = loginBtn.rx.tap.asObservable()
        viewModel.output.loginResultObservable
            .subscribe(onNext: { [weak self]result in
                withExtendedLifetime(self){
                    switch result {
                    case .success(let str):
                        NSLog(str)
                    case.failure(let error):
                        self!.showAlert(message: error.localizedDescription)
                    }
                }
            }).disposed(by: disposeBag)
        
        viewModel.output.signingIn .drive(onNext: { signingIn in
            if(signingIn){
                NSLog("signingIn")
            }else{
                NSLog("signing end ")
            }
        }).disposed(by: disposeBag)
        (userNameTextField.rx.textInput <-> viewModel.usernameVar).disposed(by: disposeBag)
        (passWordTextField.rx.textInput <-> viewModel.passwordVar).disposed(by: disposeBag)
        
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

