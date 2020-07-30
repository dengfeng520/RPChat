//
//  DeviceInfo.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/7/30.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public class DeviceInfo: NSObject {
    /// App Version 版本号
    public class var versionNum: String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "1.0" }
        return "\(infoDictionary["CFBundleShortVersionString"] ?? "1.0")"
    }
    /// App Build 版本号
    public class var build: String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "1" }
        return "\(infoDictionary["CFBundleVersion"] ?? "1")"
    }
    /// iOS 系统版本
    public class var iOSVersion: String {
        return UIDevice.current.systemVersion
    }
    /// 设备名称
    public class var systemName: String {
        return UIDevice.current.systemName
    }
    /// 设备型号
    public class var model: String {
        return UIDevice.current.model
    }
    /// 设备区域化型号
    public class var localizedModel: String {
        return UIDevice.current.localizedModel
    }
}
