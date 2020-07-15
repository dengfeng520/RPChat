//
//  UIColorExtension.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/7/1.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

extension UIColor {
    /// UIView背景颜色
    public class var darkModeViewColor: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    public class func configDarkModeViewColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    /// 文字颜色
    public class var darkModeTextColor: UIColor {
        if #available(iOS 13.0, *) {
            if drakMode == true {
                return .white
            } else {
                return .black
            }
        } else {
            return .black
        }
    }
    public class func configDarkModeTxtColor() -> UIColor {
        if #available(iOS 13.0, *) {
            if drakMode == true {
                return .white
            } else {
                return .black
            }
        } else {
            return .black
        }
    }
    /// 子UIView背景颜色
    public class var subDarkModeViewColor: UIColor {
        if #available(iOS 13.0, *) {
            if drakMode == true {
                return UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
            } else {
                return .groupTableViewBackground
            }
        } else {
            return .groupTableViewBackground
        }
    }
    public class func configSubDarkModeViewColor() -> UIColor {
        if #available(iOS 13.0, *) {
            if drakMode == true {
                return UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
            } else {
                return .groupTableViewBackground
            }
        } else {
            return .groupTableViewBackground
        }
    }
    /// 设置默认带颜色的view背景
    public class func configDarkModeViewWith(_ dfaultColor: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            if drakMode == true {
                return UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
            } else {
                return dfaultColor
            }
        } else {
            return dfaultColor
        }
    }
    /// 设置带默认颜色的文字颜色
    public class func configDarkModeTxtColorWith(_ dfaultColor: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            if drakMode == true {
                return .systemBackground
            } else {
                return dfaultColor
            }
        } else {
            return dfaultColor
        }
    }
    /// 设置Placeholder文字颜色
    public class var placeholderColor: UIColor {
        if #available(iOS 13.0, *) {
            if drakMode == true {
                return UIColor(red: 255, green: 255, blue: 255, alpha: 0.25)
            } else {
                return UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
            }
        } else {
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        }
    }
    public class func configPlaceholderColor() -> UIColor {
        if #available(iOS 13.0, *) {
            if drakMode == true {
                return UIColor(red: 255, green: 255, blue: 255, alpha: 0.25)
            } else {
                return UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
            }
        } else {
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        }
    }
}

extension UIColor {
    public class func hexadecimalColor(_ hexadecimal: String, _ alpha: CGFloat) -> UIColor {
        var cstr = hexadecimal.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        if(cstr.length < 6){
            return UIColor.clear;
        }
        if(cstr.hasPrefix("0X")){
            cstr = cstr.substring(from: 2) as NSString
        }
        if(cstr.hasPrefix("#")){
            cstr = cstr.substring(from: 1) as NSString
        }
        if(cstr.length != 6){
            return UIColor.clear;
        }
        var range = NSRange.init()
        range.location = 0
        range.length = 2
        let rStr = cstr.substring(with: range);
        range.location = 2;
        let gStr = cstr.substring(with: range)
        range.location = 4;
        let bStr = cstr.substring(with: range)
        var r :UInt32 = 0x0;
        var g :UInt32 = 0x0;
        var b :UInt32 = 0x0;
        Scanner.init(string: rStr).scanHexInt32(&r);
        Scanner.init(string: gStr).scanHexInt32(&g);
        Scanner.init(string: bStr).scanHexInt32(&b);
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
    
    public class func hexStringToColor(_ hexadecimal: String) -> UIColor {
        var cstr = hexadecimal.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        if(cstr.length < 6){
            return UIColor.clear;
        }
        if(cstr.hasPrefix("0X")){
            cstr = cstr.substring(from: 2) as NSString
        }
        if(cstr.hasPrefix("#")){
            cstr = cstr.substring(from: 1) as NSString
        }
        if(cstr.length != 6){
            return UIColor.clear;
        }
        var range = NSRange.init()
        range.location = 0
        range.length = 2
        let rStr = cstr.substring(with: range);
        range.location = 2;
        let gStr = cstr.substring(with: range)
        range.location = 4;
        let bStr = cstr.substring(with: range)
        var r :UInt32 = 0x0;
        var g :UInt32 = 0x0;
        var b :UInt32 = 0x0;
        Scanner.init(string: rStr).scanHexInt32(&r);
        Scanner.init(string: gStr).scanHexInt32(&g);
        Scanner.init(string: bStr).scanHexInt32(&b);
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }
}


extension UIColor {
    /// 当前是否是暗模式
    public class var drakMode: Bool {
        if #available(iOS 13.0, *) {
            let currentMode = UITraitCollection.current.userInterfaceStyle
            if currentMode == .dark {
                return true
            }
        }
        return false
    }
    public class func isDrakMode() -> Bool {
        if #available(iOS 13.0, *) {
            let currentMode = UITraitCollection.current.userInterfaceStyle
            if currentMode == .dark {
                return true
            }
        }
        return false
    }
}
