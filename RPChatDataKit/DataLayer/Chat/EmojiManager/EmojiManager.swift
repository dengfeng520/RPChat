//
//  EmojiManager.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2021/1/7.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public class EmojiManager: NSObject {
    /// Emoji name list
    public class var emojiNameArray: [EmojiModel]? {
        if  let emojiList = fetchPlistArray {
            let retArray: [EmojiModel] = emojiList.compactMap { (body) -> EmojiModel? in
                if let data = try? JSONSerialization.data(withJSONObject: body, options: []) {
                    return EmojiModel(data: data)
                } else {
                    return nil
                }
            }
            return retArray
        }
        return nil
    }
    
    private class var fetchPlistArray: [AnyObject]? {
        if  let path =  Bundle(for: EmojiManager.self).path(forResource: "emoji", ofType: "plist"),
            let data = FileManager.default.contents(atPath: path) {
            let emojiList = (try? PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil)) as? [AnyObject]
            return emojiList
        }
        return nil
    }
    
    /// Emoji image
    public class func fetchEmojiImage(_ name: String) -> UIImage? {
        guard let file = self.fetchBundle.path(forResource: name, ofType: "png") else {
            return nil
        }
        return UIImage(contentsOfFile: file)
    }
    
    private class var fetchBundle: Bundle {
        return Bundle(path: Bundle(for: EmojiManager.self).path(forResource: "emoji", ofType: "bundle")!)!
    }
}
