//
//  StringExtension.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/7/1.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

extension String {
   public func base64Encoded() -> String? {
     return data(using: .utf8)?.base64EncodedString()
   }
  
   public func base64Decoded() -> String? {
     guard let data = Data(base64Encoded: self) else { return nil }
     return String(data: data, encoding: .utf8)
   }
}

