//
//  ChatListViewController.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/13.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPChatDataKit
import RPChatUIKit

class ChatListViewController: UIViewController {

    let disposeBag: DisposeBag = DisposeBag()
    var viewModel: ChatViewModel = ChatViewModel()
    var chatListSub = PublishSubject<[ChatBodyModel]>()
    /// 滚动列表时键盘处理
    let openKeyboardSubject = PublishSubject<Bool>()
    /// 点击用户头像
    let headerTapSubject = PublishSubject<ChatBodyModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.// delegate
        
        setupBindViewModel()
        
        keyboardAbout()
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
        $0.backgroundColor = .groupedColor
        $0.register(LeftChatTableViewCell.self, forCellReuseIdentifier: "LeftChatTableViewCellId")
        $0.register(RightChatTableViewCell.self, forCellReuseIdentifier: "RightChatTableViewCellId")
        return $0
    }(UITableView())
    
    
    /// 滚到最底部
    func scrollWithBottom() {
        let indexPath = IndexPath(row: viewModel.chatListArray.count - 1, section: 0)
        self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .bottom)
    }
}

