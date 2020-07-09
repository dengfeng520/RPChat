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
import RPChatUIKit

open class SignInViewController: UIViewController {
    
    let viewModel: SignInViewModel = SignInViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "登录"
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.signInSuccess.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
            guard let `self` = self else { return }
            
        }).disposed(by: disposeBag)
        
        viewModel.error.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (alertMessage) in
           guard let `self` = self else { return }
           
        }).disposed(by: disposeBag)
    }
    
    public override func loadView() {
        self.view = SignInRootView.init(viewModel: viewModel)
    }
    
}
