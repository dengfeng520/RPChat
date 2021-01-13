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
    
    
    func prentsFriendInfoVC(_ model: ChatBodyModel) {
        /// 页面跳转时 关闭键盘
        closedKeyboard()
        let friendInfoVC = FriendInfoViewController()
        navigationController?.pushViewController(friendInfoVC, animated: true)
    }
}


