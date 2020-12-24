//
//  RPAuthRemoteAPI.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/22.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire
import SwiftyJSON

public enum PMKTag {
    case promise
}

public struct RPAuthRemoteAPI: AuthRemoteAPI {
    public func signIn(_ stuNum: String, _ password: String) -> Promise<SignInModel> {
        let loginInfo = LoginData(stuNum: stuNum, password: password)
        
        guard let loginData = try? JSONEncoder().encode(loginInfo) else {
            return Promise<SignInModel> { seal in
                seal.reject(DataKitError.dataCorrupt(description: "Cannot encode username and password for signning in."))
            }
        }
        return Promise<SignInModel> { seal in
            SignInModel(data: Data())
        }
    }
    
    public func post(with body: [String : AnyObject]) {
        let path = "https://www.apple.com"
        let headers: HTTPHeaders = ["Content-Type" : "application/x-www-form-urlencoded",
                                    "version" : "318",
                                    "token" : "9e678ee6-69de-47b1-a069-6ed343626f49",
                                    "appId" : "e2766ff90db544ab9b3c7eaa8b834120",
                                    "type" : "1",
                                    "channel" : "iOS"]
        // body
        var parameters = Encryption.dictWithParamerters(maps: body)
        parameters.removeValue(forKey: "appSecret")
        parameters.removeValue(forKey: "appIdr")
        
        AF.request(path, method: .post, parameters: parameters, headers: headers).response { response in
            
        }
    }
    
    private func adapter<T, U>(_ seal: Resolver<(data: T, response: U)>) -> (T?, U?, Error?) -> Void {
        return {
            t, u, e in
            if let t = t, let u = u {
                seal.fulfill((t, u))
            }
            else if let e = e {
                seal.reject(e)
            }
            else {
                seal.reject(PMKError.invalidCallingConvention)
            }
        }
    }
    
    
}

