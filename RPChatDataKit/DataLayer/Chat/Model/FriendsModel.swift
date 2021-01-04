//
//  FriendsModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/18.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

public struct FriendsModel {
    public var type,userId,userName: String
    
    public init() {
        type = ""
        userId = ""
        userName = ""
    }
}

extension FriendsModel {
    init(json: JSON) {
        type = json["type"].stringValue
        userId = json["userId"].stringValue
        userName = json["userName"].stringValue
    }
}
