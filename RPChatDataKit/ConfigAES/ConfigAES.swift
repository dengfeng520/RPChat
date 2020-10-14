//
//  ConfigAES.swift
//  RPChatDataKit
//  AES加密相关
//  Created by rp.wang on 2020/7/1.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import CryptoSwift

public class ConfigAES: NSObject {
    /// 密钥
    let publicKey = "thanks,pig4cloud"
    
    public func encryptStringWith(strToEncode: String) -> String {
        
        let data = strToEncode.data(using: String.Encoding.utf8)
        // byte 数组
        var encrypted: [UInt8] = []
        let (key, iv) = fetchAESKeyAndIv(publicKey.base64Encoded!)
        do {
            encrypted = try AES(key: key, blockMode: CBC(iv: iv), padding: .zeroPadding).encrypt(data!.bytes)
        } catch {
            print(error)
        }
        let encoded = Data(encrypted)
        // 加密结果要用Base64转码
        return encoded.base64EncodedString()
    }
    
    func fetchAESKeyAndIv(_ base64edMixedKey: String) -> (Array<UInt8>, Array<UInt8>) {
        let key = Array<UInt8>(Data(base64Encoded: base64edMixedKey)!)
        let iv = Array<UInt8>(Data(base64Encoded: base64edMixedKey)!)
        
        return (key, iv)
    }
}
