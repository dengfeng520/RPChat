//
//  RPBannerViewProtocol.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/7/9.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public protocol BannerViewProtocol {
    var mode: bannerMode? {get}
    var context: String? {get}
    var addView: UIView? {get}
    var isTime: Double? {get}
}

// MARK: - toast mode
public enum bannerMode : Int {
    case warningMode
    case successMode
    case perfectionMode
    case loadingMode
}


// TODO: 后期预留
public enum pathMode : Int {
    case centerMode
    case topMode
    case bottomMode
}
