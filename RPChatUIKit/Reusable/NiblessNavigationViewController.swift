//
//  NiblessNavigationViewController.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/8/26.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit

class NiblessNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .darkModeViewColor
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .default
        navigationBar.tintColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem()
        navigationItem.backBarButtonItem?.title = ""
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.init(name: "PingFangSC-Semibold", size: 19) as Any]
        navigationBar.barTintColor = .hexStringToColor("0xF5BE62")
    }
    
}
