//
//  StringExtension.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/7/1.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import CommonCrypto

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

extension String {
    /// md5 加密
    public var md5: String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02x", $1) }
    }
    /// 获取当前时间
    public var fetchSystemCurrentTime: String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let time = dformatter.string(from: Date())
        return "\(time)"
    }
}

extension String {
    /// 国际化
    public static func localized(of key: String, comment: String = "") -> String {
        return NSLocalizedString(key,
                                 tableName: "Localizable",
                                 bundle: Bundle.init(identifier: "io.RPChat")!,
                                 comment: comment)
    }
}

extension String {
    /// 是否是汉字
    public var isIncludeChinese: Bool {
        for ch in self.unicodeScalars {
            // 中文字符范围：0x4e00 ~ 0x9fff
            if (0x4e00 < ch.value  && ch.value < 0x9fff) {
                return true
            }
        }
        return false
    }
    /// 转换为拼音 获取大写的首字母
    public var transformToPinyin: String? {
        let stringRef = NSMutableString(string: self) as CFMutableString
        // 转换为带音标的拼音
        CFStringTransform(stringRef, nil, kCFStringTransformToLatin, false)
        // 去掉音标
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false)
        let pinyin = stringRef as String
        
        let upperStr = pinyin.first?.uppercased() ?? "#"
        
        return upperStr
    }
    /// 获取大写的首字母
    public var fetchPinyinHead: String {
        // 获取第一个字母
        let upperStr = self.transformToPinyin?.first
        
        return upperStr?.uppercased() ?? "#"
    }
}
