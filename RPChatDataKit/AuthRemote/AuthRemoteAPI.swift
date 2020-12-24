//
//  AuthRemoteAPI.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/22.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import PromiseKit

public protocol AuthRemoteAPI {
    func signIn(_ stuNum: String,_ password: String) -> Promise<SignInModel>
}
