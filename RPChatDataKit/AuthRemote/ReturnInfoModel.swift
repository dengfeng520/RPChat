//
//  ReturnInfoModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/31.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public struct ReturnInfoModel {
    var returnMsg: String = String()
    var returnCode: String = String()
    
    private enum CodingKeys: String,CodingKey {
        case returnMsg
        case returnCode
    }
}

extension ReturnInfoModel: Codable {
    public init?(data: Data) {
        guard let model = try? JSONDecoder().decode(ReturnInfoModel.self, from: data) else { return nil }
        self = model
    }
}
