//
//  CurrentTime.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/18.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public class CurrentTime: NSObject {
    ///
    public class func fetchTimeInterval(_ time: String) -> String {
        if time.count >= 10 {
            let serverTime = time.subString(from: 0, to: 10)
            let nowtime = self.fetchSystemCurrentTime.subString(from: 0, to: 10)
            if serverTime == nowtime {
                if time.count >= 19 {
                    return time.subString(from: 12, to: 16)
                }
            } else {
                return time.subString(from: 6, to: 10)
            }
        }
        return ""
    }
    
   /// 获取当前时间
    public class var fetchSystemCurrentTime: String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let time = dformatter.string(from: Date())
        return "\(time)"
    }
}
