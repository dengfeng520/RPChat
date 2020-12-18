//
//  ConversatModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/17.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

public struct ConversatModel {
    var status,userId,type,groupId,lastMsg,userName,createTime,photo: String
    var isCache: Bool
}

extension ConversatModel {
    init(json: JSON) {
        status = json["status"].stringValue
        userId = json["userId"].stringValue
        type = json["type"].stringValue
        groupId = json["groupId"].stringValue
        lastMsg = json["lastMsg"].stringValue
        userName = json["userName"].stringValue
        createTime = json["createTime"].stringValue
        photo = json["photo"].stringValue
        isCache = false
    }
}
