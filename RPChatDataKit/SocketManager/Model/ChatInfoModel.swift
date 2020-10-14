//
//  ChatInfoModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/10/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ChatInfoModel: Codable {
    var school: String?
    let serverIp,collectPhoto: String
    let port: Int
}

extension ChatInfoModel {
    init?(data: Data) {
        guard let model = try? JSONDecoder().decode(ChatInfoModel.self, from: data) else { return nil }
        self = model
    }
    
    init(json: JSON) {
        port = json["port"].intValue
        serverIp = json["serverIp"].stringValue
        collectPhoto = json["collectPhoto"].stringValue
        school = json["school"].stringValue
    }
}
