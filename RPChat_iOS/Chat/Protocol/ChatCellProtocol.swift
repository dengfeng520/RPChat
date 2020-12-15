//
//  ChatCellProtocol.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/15.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

protocol ChatCellProtocol {
    var nickeNameLab: UILabel { get }
    var headerImg: UIImageView { get }
    var messageRootView: UIView { get }
    var messageLab: UILabel { get }
}
