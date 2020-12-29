//
//  SignInModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/7/1.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

public struct SignInModel {
    public let username,dept_id,access_token,token_type,user_id,scope,refresh_token,expires_in,license: String
    
    private enum CodingKeys: String,CodingKey {
        case username
        case dept_id
        case access_token
        case token_type
        case user_id
        case scope
        case refresh_token
        case expires_in
        case license
    }
}

extension SignInModel: Codable {
    public init?(data: Data) {
        guard let model = try? JSONDecoder().decode(SignInModel.self, from: data) else { return nil }
        self = model
    }
    
    public init?(json: JSON) {
        username = json["username"].stringValue
        dept_id = json["dept_id"].stringValue
        access_token = json["access_token"].stringValue
        token_type = json["token_type"].stringValue
        user_id = json["user_id"].stringValue
        scope = json["scope"].stringValue
        refresh_token = json["refresh_token"].stringValue
        expires_in = json["expires_in"].stringValue
        license = json["license"].stringValue
    }
}
