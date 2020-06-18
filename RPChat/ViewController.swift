//
//  ViewController.swift
//  RPChat
//  f4c30d
//  Created by rp.wang on 2020/6/15.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testLab.text = NSLocalizedString("测试", comment: "")
    }


    
}

