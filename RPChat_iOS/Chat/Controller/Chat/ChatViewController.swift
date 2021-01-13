//
//  ChatViewController.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit
import RxSwift
import RPChatUIKit
import RPBannerView

class ChatViewController: UIViewController {
    let viewModel: ChatViewModel = ChatViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    var toolBoxHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configChatUI()
    }
    /// 消息列表
    lazy var chatListView: UIView = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        $0.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        $0.bottomAnchor.constraint(equalTo: toolBoxView.topAnchor, constant: 0).isActive = true
        return $0
    }(UIView())

    lazy var chatListVC: ChatListViewController = {
        $0.viewModel = self.viewModel
        self.add(asChildViewController: $0, to: chatListView)
        return $0
    }(ChatListViewController())
    /// 工具栏
    lazy var toolBoxVC: ToolBoxViewController = {
        self.add(asChildViewController: $0, to: toolBoxView)
        return $0
    }(ToolBoxViewController())
    
    lazy var toolBoxView: UIView = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        $0.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        toolBoxHeight = $0.heightAnchor.constraint(equalToConstant: 55)
        toolBoxHeight.isActive = true
        return $0
    }(UIView())
    
    lazy var socket: SocketManager = {
        return SocketManager.sharedInstance
    }()
    
    /// 构建Socket
    func configSocketManager() {
        if socket.isSigin == true && socket.isConnect == true {
            
        }
    }
}


