//
//  DiscoverViewController.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/4.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift

class DiscoverViewController: UIViewController {
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenBackTitle()
        title = NSLocalizedString("Discover", comment: "")
        // Do any additional setup after loading the view.
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let downVC = DownloadImageViewController()
//        downVC.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(downVC, animated: true)
        
        let serialVC = SerialQueueViewController()
        serialVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(serialVC, animated: true)
    }
}
