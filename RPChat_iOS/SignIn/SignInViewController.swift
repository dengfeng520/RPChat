//
//  SignInViewController.swift
//  StudentRunning
//
//  Created by rp.wang on 2020/6/17.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPChatDataKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var stuNumberRootView: UIView!
    @IBOutlet weak var pawRootView: UIView!
    @IBOutlet weak var signinBtn: UIButton!
    
    @IBOutlet weak var inputStuNumTxt: UITextField!
    @IBOutlet weak var inputPassWordTxt: UITextField!
    @IBOutlet weak var logoImg: UIImageView!
    
    @IBOutlet weak var changeSecureBtn: UIButton!
    
    let viewModel: SignInViewModel = SignInViewModel()
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "登录"
        configUI()
        bindDataSource()
    }

    private func configUI() {
        stuNumberRootView.layer.cornerRadius = 30
        pawRootView.layer.cornerRadius = 30
        signinBtn.layer.cornerRadius = 25
        logoImg.layer.cornerRadius = 60
        
        changeSecureBtn.isSelected = false
        inputPassWordTxt.isSecureTextEntry = true
        changeSecureBtn.setImage(UIImage.init(named: "ciphertext_password"), for: .normal)
        
        stuNumberRootView.backgroundColor = UIColor.groupTableViewBackground
        pawRootView.backgroundColor = UIColor.groupTableViewBackground
    }
    
    private func bindDataSource() {
//        SignInViewModel.configKeyBoard()
        bindViewModelToStuNumField()
        bindViewModelToPassWordField()
        bindViewModelToSignInButton()
        bindChangePwdBtn()
    }
    
    private func bindViewModelToStuNumField() {
        inputStuNumTxt.rx.text.asDriver().map {
            $0 ?? ""
        }.drive(viewModel.inputStuNum).disposed(by: disposeBag)
        
        viewModel.inputStuNumEnabled.asDriver(onErrorJustReturn: true).drive(inputStuNumTxt.rx.isEnabled).disposed(by: disposeBag)
    }
    
    private func bindViewModelToPassWordField() {
        inputPassWordTxt.rx.text.asDriver().map {
            $0 ?? ""
        }.drive(viewModel.inputPassWord).disposed(by: disposeBag)
        
        viewModel.inputPassWordEnabled.asDriver(onErrorJustReturn: true).drive(inputPassWordTxt.rx.isEnabled).disposed(by: disposeBag)
    }
    
   private func bindViewModelToSignInButton() {
       viewModel.signInButtonEnabled.subscribe {
         guard let status = $0.element else { return }
         if !status {
           self.signinBtn.alpha = 0.6
           self.signinBtn.isEnabled = false
         } else {
           self.signinBtn.alpha = 1.0
           self.signinBtn.isEnabled = true
         }
       }.disposed(by: disposeBag)
      
      signinBtn.rx.tap.bind(to: viewModel.signInButtonTapped).disposed(by: disposeBag)
      
      viewModel.error.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
//         guard let `self` = self else { return }
         print("登录失败============")
      }).disposed(by: disposeBag)
    
      viewModel.signInSuccess.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
          guard let `self` = self else { return }
//          let tabBarVC = TSNTabBarViewController()
//          tabBarVC.modalPresentationStyle = .custom
//          self.navigationController?.present(tabBarVC, animated: false, completion: {
//
//          })
//          RPBannerView.show(with: .successMode, body: "登录成功", isView: self.view)
      }).disposed(by: disposeBag)
    }
    
    private func bindChangePwdBtn() {
        changeSecureBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            self.changeSecureBtn.isSelected = !self.changeSecureBtn.isSelected
            if self.changeSecureBtn.isSelected == true {
               self.inputPassWordTxt.isSecureTextEntry = false
               self.changeSecureBtn.setImage(UIImage.init(named: "clear_text_password"), for: .normal)
            } else {
               self.inputPassWordTxt.isSecureTextEntry = true
               self.changeSecureBtn.setImage(UIImage.init(named: "ciphertext_password"), for: .normal)
            }
        }).disposed(by: disposeBag)
    }
}
