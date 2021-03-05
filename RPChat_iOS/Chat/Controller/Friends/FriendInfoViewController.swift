//
//  FriendInfoViewController.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/5.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatUIKit

class FriendInfoViewController: UIViewController {
    
    let testA = TestA()
    var isRight: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenBackTitle()
        // Do any additional setup after loading the view.
//        testClosures = { [unowned self] in
//            self.testA.configTestA()
//        }
        
        testA.testClosures = { [weak self] (select) in
            self?.isRight = select == "B" ? true : false
        }
    }
    
    deinit {
        print("---------------------deinit")
    }
}
