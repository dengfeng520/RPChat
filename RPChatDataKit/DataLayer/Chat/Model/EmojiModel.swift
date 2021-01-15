//
//  EmojiModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2021/1/7.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

public struct EmojiModel: Codable {
    public var face_name: String
    public var face_id: String
    public var isCache: Bool
    
    private enum CodingKeys: String,CodingKey {
        case face_name
        case face_id
        case isCache
    }
}

extension EmojiModel {
    public init?(data: Data) {
        guard let model = try? JSONDecoder().decode(EmojiModel.self, from: data) else { return nil }
        self = model
    }
    
    public init?(json: JSON) {
        self.face_name = json["face_name"].stringValue
        self.face_id = json["face_id"].stringValue
        self.isCache = false
    }
}
