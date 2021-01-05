//
//  ChatCellProtocol.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/15.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

enum mineOrOtherMode {
    case mineMode
    case othersMode
}

protocol ChatCellProtocol {
    var nickeNameLab: UILabel { get }
    var headerImg: UIButton { get }
    var messageRootView: UIView { get }
    var messageLab: UILabel { get }
    var stype: mineOrOtherMode? { get }
}

extension ChatCellProtocol {
    func configReceivedUI() { }
    func configSendUI() { }
}
