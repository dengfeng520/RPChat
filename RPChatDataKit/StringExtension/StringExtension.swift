//
//  StringExtension.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/7/1.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

extension String {
    /// Base64 加密
    public var base64Encoded: String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    /// Base64 解密
    public var base64Decoded: String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    /// 是否包含字符串
    public func containsWith(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    public func containsIgnoringCaseWith(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    /// 从任意位置开始截取到任意位置
    public func subString(from: Int, to: Int) -> String {
        let beginIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[beginIndex...endIndex])
    }
    /// 去掉字符串中所有的空格
    public var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    /// 去掉字符串中所有的换行
    public var removeAllLineBreak: String {
        return self.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
    }
}

