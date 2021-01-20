//
//  Encryption.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/24.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public class Encryption: NSObject {
    /// 获取当前时间戳
    public class func fetchSystemCurrentTime() -> String {
        //获取当前时间
        let now = NSDate()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        //当前时间的时间戳
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval) * 1000
        return "\(timeStamp)"
    }
    /// key value 遍历
    public class func charSortWithMaps(_ maps: Dictionary<String, AnyObject>) -> String {
        let keys = maps.keys
        let results: [String] = keys.sorted()
        var sortStr: String = String()
        results.forEach { (categoryId) in
            if var value = maps[categoryId] {
                if value is Dictionary<String, AnyObject> {
                    value = charSortWithMaps(value as! Dictionary<String, AnyObject>) as AnyObject
                }
                if value is Dictionary<String, String> {
                    value = charSortWithMaps(value as! Dictionary<String, AnyObject>) as AnyObject
                }
                if sortStr.count != 0 {
                    sortStr = sortStr + "&"
                }
                sortStr = sortStr.appendingFormat("\(categoryId)=\(value)")
            }
        }
        return sortStr
    }
    /// 加密处理
    public class func dictWithParamerters(maps: Dictionary<String, AnyObject>) -> Dictionary<String, AnyObject> {
        let timer = fetchSystemCurrentTime()
        var muMaps = maps
        muMaps.updateValue(timer as AnyObject, forKey: "timestamp")
        muMaps.updateValue(appkey as AnyObject, forKey: "appSecret")
        muMaps.updateValue("e2766ff90db544ab9b3c7eaa8b834120" as AnyObject, forKey: "appId")
        let charStr = charSortWithMaps(muMaps)
        let signValidate = charStr.md5
        muMaps.updateValue(signValidate as AnyObject, forKey: "sign")
        return muMaps
    }
}
