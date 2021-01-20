//
//  AddressBookModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ContactsModel: Codable {
    public var type,Id,name,picture,introduction: String

    private enum CodingKeys: String,CodingKey {
        case type
        case Id
        case name
        case picture
        case introduction
    }
}

extension ContactsModel {
    public init?(data: Data) {
        guard let model = try? JSONDecoder().decode(ContactsModel.self, from: data) else { return nil }
        self = model
    }
}
