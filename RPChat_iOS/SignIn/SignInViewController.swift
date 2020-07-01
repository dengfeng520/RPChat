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
        configUI()
    }

    private func configUI() {
        rootView.backgroundColor = UIColor.configDarkModeRootViewColor()
    }
    
    lazy var rootView: SignInRootView = {
        let rootView = SignInRootView.init(frame: view.bounds)
        view.addSubview(rootView)
        return rootView
    }()
    
}
