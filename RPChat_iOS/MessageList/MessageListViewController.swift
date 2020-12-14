//
//  MessageListViewController.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/8/26.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit
import RPChatUIKit
import RxSwift
import RxCocoa

class MessageListViewController: UIViewController {

    let viewModel: MessageListViewModel = MessageListViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
        title = NSLocalizedString("Message List", comment: "")
    }

    private func configUI() {
        view.backgroundColor = .darkModeViewColor
        
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewModel.configBOOL()        
    }
    
}
