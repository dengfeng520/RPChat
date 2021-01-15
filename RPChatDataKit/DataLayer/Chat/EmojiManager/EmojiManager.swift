//
//  EmojiManager.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2021/1/7.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

public class EmojiManager: NSObject {
    /// Emoji name list
    public class var emojiNameArray: [EmojiModel]? {
        if  let emojiList = fetchPlistArray {
            let retArray: [EmojiModel] = emojiList.compactMap { (body) -> EmojiModel? in
                return EmojiModel(json: JSON(body))
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


extension EmojiManager {
    /// 表情包
    public class var fetchEmoticonsList: [[EmojiModel]]? {
        var emojiList = [[EmojiModel]]()
        var ghost = [EmojiModel]()
        var cat = [EmojiModel]()
        for index in 0..<10 {
            
            let ghostModel = converFhostModel(index)
            ghost.append(ghostModel)
            
            let catModel = coverCatModel(index)
            cat.append(catModel)
        }
        emojiList.append(ghost)
        emojiList.append(cat)
        
        if let emojiNameArray = emojiNameArray {
            print("face_name=================\(emojiNameArray)")
            emojiList.insert(emojiNameArray, at: 0)
        }
        return emojiList
    }
    
    private class func converFhostModel(_ index: Int) -> EmojiModel {
        var model = EmojiModel(json: JSON([:]))
        model?.face_name = "ghost\(index)"
        model?.face_id = "ghost_\(index)"
        model?.isCache = true
        return model!
    }
    
    private class func coverCatModel(_ index: Int) -> EmojiModel {
        var model = EmojiModel(json: JSON([:]))
        model?.face_name = "cat\(index)"
        model?.face_id = "cat_\(index)"
        model?.isCache = true
        return model!
    }
}
