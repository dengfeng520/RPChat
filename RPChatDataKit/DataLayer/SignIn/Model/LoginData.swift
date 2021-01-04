//
//  LoginData.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/22.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public struct LoginData: Codable {
    /// - Properties
    public let stuNum: String
    public let password: String
    
    /// - Methods
    init(stuNum: String, password: String) {
        self.stuNum = stuNum
        self.password = password
    }
}
