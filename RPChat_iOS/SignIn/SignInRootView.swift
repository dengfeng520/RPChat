//
//  SignInRootView.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/6/22.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPChatUIKit

class SignInRootView: UIView {
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        logoImg.image = UIImage(named: "logo_icon")
        
        accountNumberLab.placeholder = NSLocalizedString("please input username", comment: "")
        inputPasswordTxt.placeholder = NSLocalizedString("please input password", comment: "")
        
        signInBtn.rx.tap.subscribe(onNext: {
            
        }).disposed(by: disposeBag)
    }
    
    lazy var logoImg: UIImageView = {
        self.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        let top = $0.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 44)
        let centerX = $0.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        let width = $0.widthAnchor.constraint(equalToConstant: 120)
        let height = $0.heightAnchor.constraint(equalToConstant: 120)
        NSLayoutConstraint.activate([top, centerX, width, height])
        return $0
    }(UIImageView())
    
    
    lazy var accountNumberView: UIView = {
        self.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        let top = $0.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant: 20)
        let left = $0.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40)
        let right = $0.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40)
        let height = $0.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([top, left, right, height])
        $0.backgroundColor = UIColor.configDarkModeViewColorWithdDfaultColor(dfaultColor: UIColor.groupTableViewBackground)
        $0.layer.cornerRadius = 25
        return $0
    }(UIView())
 
    
    lazy var accountNumberLab: UITextField = {
        accountNumberView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: accountNumberView.topAnchor, constant: 0).isActive = true
        $0.leftAnchor.constraint(equalTo: accountNumberView.leftAnchor, constant: 16).isActive = true
        $0.rightAnchor.constraint(equalTo: accountNumberView.rightAnchor, constant: -16).isActive = true
        $0.bottomAnchor.constraint(equalTo: accountNumberView.bottomAnchor, constant: 0).isActive = true
        $0.font = UIFont.init(name: "PingFangTC-Semibold", size: 19)
        return $0
    }(UITextField())
    
    
    lazy var inputPasswordView: UIView = {
           self.addSubview($0)
           $0.translatesAutoresizingMaskIntoConstraints = false
           let top = $0.topAnchor.constraint(equalTo: accountNumberView.bottomAnchor, constant: 20)
           let left = $0.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40)
           let right = $0.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40)
           let height = $0.heightAnchor.constraint(equalToConstant: 50)
           NSLayoutConstraint.activate([top, left, right, height])
           $0.backgroundColor = UIColor.configDarkModeViewColorWithdDfaultColor(dfaultColor: UIColor.groupTableViewBackground)
           $0.layer.cornerRadius = 25
           return $0
       }(UIView())
    
       
    lazy var inputPasswordTxt: UITextField = {
           inputPasswordView.addSubview($0)
           $0.translatesAutoresizingMaskIntoConstraints = false
           $0.topAnchor.constraint(equalTo: inputPasswordView.topAnchor, constant: 0).isActive = true
           $0.leftAnchor.constraint(equalTo: inputPasswordView.leftAnchor, constant: 16).isActive = true
           $0.rightAnchor.constraint(equalTo: inputPasswordView.rightAnchor, constant: -16).isActive = true
           $0.bottomAnchor.constraint(equalTo: inputPasswordView.bottomAnchor, constant: 0).isActive = true
           $0.font = UIFont.init(name: "PingFangTC-Semibold", size: 19)
           return $0
       }(UITextField())
    
    
    lazy var signInBtn: UIButton = {
        self.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        let top = $0.topAnchor.constraint(equalTo: inputPasswordView.bottomAnchor, constant: 20)
        let left = $0.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40)
        let right = $0.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40)
        let height = $0.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([top, left, right, height])
        $0.layer.cornerRadius = 25
        $0.titleLabel?.font = UIFont.init(name: "PingFangTC-Semibold", size: 20)
        $0.setTitle(NSLocalizedString("Sign In", comment: ""), for: .normal)
        $0.backgroundColor = UIColor.hexStringToColor(hexadecimal: "0xF5BE62")
        return $0
    }(UIButton())
}
