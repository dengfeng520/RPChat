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
import RPBannerView

class ChatViewController: UIViewController {

    
    let viewModel: ChatViewModel = ChatViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hiddenBackTitle()
        bindViewModel()
        configSocketManager()
    }
    
    lazy var tableView: UITableView = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        let top = $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        let left = $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        let width = $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        let bottom = $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([top, left, width, bottom])
        $0.tableFooterView = UIView()
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 60
        $0.separatorStyle = .none
        $0.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatTableViewCellId")
        return $0
    }(UITableView())
    
    lazy var socket: SocketManager = {
        return SocketManager.sharedInstance()
    }()
    
    /// 构建Socket
    private func configSocketManager() {
        if socket.isSigin == true && socket.isConnect == true {
            
        }
    }
}


