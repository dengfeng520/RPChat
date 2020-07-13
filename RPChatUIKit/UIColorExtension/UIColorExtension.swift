//
//  UIColorExtension.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/7/1.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

extension UIColor {
   open class func hexadecimalColor(_ hexadecimal: String, alpha: CGFloat) -> UIColor {
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
    
    open class func hexStringToColor(_ hexadecimal: String) -> UIColor {
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
    
    open class func configDarkModeRootViewColor() -> UIColor {
        let retColor: UIColor!
        if #available(iOS 13.0, *) {
            retColor = UIColor { (collection) -> UIColor in
                if (collection.userInterfaceStyle == .dark) {
                    return UIColor.systemBackground
                }
                return UIColor.systemBackground
            }
        } else {
            return UIColor.white
        }
        return retColor
    }
    
   open class func configDarkModeViewColor() -> UIColor {
        let retColor: UIColor!
        if #available(iOS 13.0, *) {
            retColor = UIColor { (collection) -> UIColor in
                if (collection.userInterfaceStyle == .dark) {
                    return UIColor.init(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
                }
                return UIColor.white
            }
        } else {
            return UIColor.white
        }
        return retColor
    }
  
    open class func configDarkModeViewColorWithdDfaultColor(_ dfaultColor: UIColor) -> UIColor {
        let retColor: UIColor!
        if #available(iOS 13.0, *) {
            retColor = UIColor { (collection) -> UIColor in
                if (collection.userInterfaceStyle == .dark) {
                    return UIColor.init(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
                }
                return dfaultColor
            }
        } else {
            return dfaultColor
        }
        return retColor
    }
    
    open class func configDarkModeTxtColor () -> UIColor {
        let retColor: UIColor!
        if #available(iOS 13.0, *) {
            retColor = UIColor { (collection) -> UIColor in
                if (collection.userInterfaceStyle == .dark) {
                    return UIColor.white
                }
                return UIColor.black
            }
        } else {
            return UIColor.black
        }
        return retColor
    }
    
   open class func configDarkModeTxtColorWithdDfaultColor(_ dfaultColor: UIColor) -> UIColor {
        let retColor: UIColor!
        if #available(iOS 13.0, *) {
            retColor = UIColor { (collection) -> UIColor in
                if (collection.userInterfaceStyle == .dark) {
                    return UIColor.systemBackground
                } else {
                    return dfaultColor
                }
            }
        } else {
            return dfaultColor
        }
        return retColor
    }
    
   open class func configPlaceholderTxtColor() -> UIColor {
        let retColor: UIColor!
        if #available(iOS 13.0, *) {
            retColor = UIColor { (collection) -> UIColor in
                if (collection.userInterfaceStyle == .dark) {
                    return UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.25)
                }
                return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.25)
            }
        } else {
            return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.25)
        }
        return retColor
    }
}
