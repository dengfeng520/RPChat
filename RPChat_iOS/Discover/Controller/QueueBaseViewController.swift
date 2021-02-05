//
//  QueueBaseViewController.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/2/5.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatUIKit

class QueueBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    lazy var fpsLab: RPChatFPSLabel = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        $0.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 120).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.textColor = .red
        $0.textAlignment = .center
        $0.isHidden = true
        return $0
    }(RPChatFPSLabel(frame: .zero))

}
