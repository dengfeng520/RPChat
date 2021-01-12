//
//  ChatViewController+Datasource.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/12.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit

extension ChatViewController {
    /// 滚到最底部
    func scrollWithBottom() {
        let indexPath = IndexPath(row: viewModel.receiveChatArray.count - 1, section: 0)
        self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .bottom)
    }
    
    func prentsFriendInfoVC(_ model: ChatBodyModel) {
        /// 页面跳转时 关闭键盘
        closedKeyboard()
        let friendInfoVC = FriendInfoViewController()
        navigationController?.pushViewController(friendInfoVC, animated: true)
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.receiveChatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatTableViewCell = ChatCellShopFactory.createCell(model: viewModel.receiveChatArray[indexPath.row], tableView: tableView, indexPath: indexPath) as! ChatTableViewCell
        
        cell.headerTapClosures = { [weak self] in
            guard let `self` = self else { return }
            self.prentsFriendInfoVC(self.viewModel.receiveChatArray[indexPath.row])
        }
       
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
