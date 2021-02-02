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
import RPBannerView
import RPKeychain

public class SignInViewController: UIViewController {
    
    let viewModel: SignInViewModel = SignInViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = NSLocalizedString("Sign In", comment: "")
        
        bindViewModel()
        
        dismissKeyboard()
    }
    
    private func bindViewModel() {
        // loading
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        // 成功
        viewModel.successSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
            guard let `self` = self else { return }
            RPBannerView.show(with: .perfectionMode, body: NSLocalizedString("Sign In Successful", comment: ""), isView: self.view)
            RPKeychain.default.set("\(self.viewModel.inputStuNum)", forKey: "key.siginInfo.value")
            DispatchQueue.main.async {
                let tabbarVC = UITabBarControllerExtension()
                let transtition = CATransition()
                transtition.duration = 0.35
                transtition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
                self.view.window?.layer.add(transtition, forKey: "animation")
                tabbarVC.modalPresentationStyle = .overFullScreen
                self.view.window?.rootViewController = tabbarVC
                self.view.window?.makeKeyAndVisible()
            }
        }).disposed(by: disposeBag)
        // 失败
        viewModel.errorSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (alertMessage) in
            guard let `self` = self else { return }
            RPBannerView.show(with: .perfectionMode, body: NSLocalizedString("Sign In Failed", comment: ""), isView: self.view)
        }).disposed(by: disposeBag)
    }
    
    public override func loadView() {
        self.view = SignInRootView(viewModel: viewModel)
    }
}

extension SignInViewController {
    // 键盘处理
    private func dismissKeyboard() {
        let tap = UITapGestureRecognizer()
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        tap.rx.event.subscribe(onNext: {  [weak self] recognizer in
            guard let `self` = self else { return }
            self.view.endEditing(true)
        }).disposed(by: disposeBag)
    }
}
