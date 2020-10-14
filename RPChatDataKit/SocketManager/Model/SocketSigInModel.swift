//
//  SocketSigInModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/10/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SocketSigInModel: Codable {
    var cmdCode: UInt16 = 0
    var msg: String = String()
}


struct MessageIdModel: Codable {
    let messageId: String
}

extension MessageIdModel {
    init?(json: JSON) {
        messageId = json["messageId"].stringValue
    }
}
