//
//  ChatViewController+Server.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/8.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

extension ChatViewController {
    func configChatArrayData() {
        var parameter = [String : String]()
        if viewModel.friendsModel.type == "1" {
            parameter = ["type":"\(viewModel.friendsModel.type)",
                         "userId":"\(viewModel.friendsModel.userId)",
                         "pageSize":"20",
                         "pageIndex":"\(1)"]
        } else {
            parameter = ["type":"\(viewModel.friendsModel.type)",
                         "groupId":"\(viewModel.friendsModel.userId)",
                         "pageSize":"20",
                         "pageIndex":"\(1)"]
        }
        print("parameter-------------\(parameter)")
        viewModel.fetchChatList(parameter)
    }
}
