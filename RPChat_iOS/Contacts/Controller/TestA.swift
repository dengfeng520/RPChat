//
//  TestA.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/3/3.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

class TestA: NSObject {
    
    var testClosures: ((String) -> Void)? = nil
    
    override init() {
        super.init()
        
    }
    
    func configTestA() {
        guard let testClosures = testClosures else {
            return
        }
        testClosures("B")
        print("================")
    }
}
