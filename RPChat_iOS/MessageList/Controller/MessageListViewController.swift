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
import RPBannerView

class MessageListViewController: UIViewController {

    let viewModel: MessageListViewModel = MessageListViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = NSLocalizedString("Chats", comment: "")
        bindViewModel()
        hiddenBackTitle()
    }
    
    lazy var tableView: UITableView = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        let top = $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        let left = $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        let width = $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        let bottom = $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([top, left, width, bottom])
        $0.separatorStyle = .none
        $0.register(MessageListTableViewCell.self, forCellReuseIdentifier: "MessageListTableViewCellId")
        return $0
    }(UITableView())
}

extension MessageListViewController: UITableViewDelegate {
    func bindViewModel() {
        // loading
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        // 获取会话列表
        viewModel.fetchMessageList()
        // 连接Socket服务器
//        viewModel.fetchChatInformation()
        // subject
        viewModel.messageListSubject.bind(to: tableView.rx.items(cellIdentifier: "MessageListTableViewCellId", cellType: MessageListTableViewCell.self)) { (row, model, cell) in
            cell.configMessageListData(model)
        }.disposed(by: disposeBag)
        // error
        viewModel.error.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
            guard let `self` = self else { return }
            RPBannerView.show(with: .perfectionMode, body: error, isView: self.view)
        }).disposed(by: disposeBag)
        // selected
        tableView.rx.itemSelected.bind { [weak self] (indexPath) in
            guard let `self` = self else { return }
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.presentChatVC(self.viewModel.messageListArray[indexPath.row])
        }.disposed(by: disposeBag)
        // delegate
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension MessageListViewController {
    func presentChatVC(_ withModel: MessageModel) {
        let chatVC = ChatViewController()
        chatVC.hidesBottomBarWhenPushed = true
        chatVC.viewModel.friendsModel = viewModel.converFriendsModel(withModel)
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
}
