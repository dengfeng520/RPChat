//
//  UINavigationControllerExtension.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/12/11.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do open any additional setup after loading the view.
        
        configUI()
    }
    
    func configUI() {
        navigationBar.barTintColor = .configSubViewColorWith(.hexStringToColor("0xF5BE62"))
        navigationBar.tintColor = .darkModeTextColor
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [.font : UIFont(name: "PingFangSC-Semibold", size: 18)!]
    }
}
