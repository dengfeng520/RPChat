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
    
    enum CodingKeys: String, CodingKey {
        case cmdCode
        case msg
    }
}
extension SocketSigInModel {
    init?(data: Data) {
        guard let model = try? JSONDecoder().decode(SocketSigInModel.self, from: data) else { return nil }
        self = model
    }
}


public struct MessageIdModel: Codable {
    public let messageId: String
    
    enum CodingKeys: String, CodingKey {
        case messageId
    }
}
extension MessageIdModel {
    init?(data: Data) {
        guard let model = try? JSONDecoder().decode(MessageIdModel.self, from: data) else { return nil }
        self = model
    }
    
    init?(json: JSON) {
        messageId = json["messageId"].stringValue
    }
}
