//
//  ChatListViewController+DataSource.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/13.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatUIKit

extension ChatListViewController: UITableViewDelegate,UITableViewDataSource {
    func setupBindViewModel() {
        // message list
        chatListSub.subscribe(onNext: { [weak self] chatList in
            guard let `self` = self else { return }
            self.tableView.reloadData()
            self.scrollWithBottom()
        }).disposed(by: disposeBag)
        // delegate
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        // dataSource
        tableView.rx.setDataSource(self).disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chatListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatTableViewCell = ChatCellShopFactory.createCell(model: viewModel.chatListArray[indexPath.row], tableView: tableView, indexPath: indexPath) as! ChatTableViewCell
        
        // 点击事件
        cell.headerTapClosures = { [weak self] in
            guard let `self` = self else { return }
            self.headerTapSubject.onNext(self.viewModel.chatListArray[indexPath.row])
        }
       
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
