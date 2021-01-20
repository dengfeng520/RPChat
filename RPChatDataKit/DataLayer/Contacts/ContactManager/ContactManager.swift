//
//  ContactManager.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2021/1/15.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public class ContactManager: NSObject {
    /// 首字母去重后的分组
    public static var groupArrasy: [String] = [String]()
    
    /// contacts list
    public class var seetArray: [ContactsModel]? {
        if let contactList = fetchPlistDataArray {
            let retArray: [ContactsModel] = contactList.compactMap { (body) -> ContactsModel? in
                let  data: Data? = try? JSONSerialization.data(withJSONObject: body, options: []) 
                return ContactsModel(data: data ?? Data())
            }
            return retArray
        }
        return nil
    }
    
    private class var fetchPlistDataArray: [AnyObject]? {
        if  let path =  Bundle(for: ContactManager.self).path(forResource: "Contacts", ofType: "plist"),
            let data = FileManager.default.contents(atPath: path) {
            let emojiList = (try? PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil)) as? [AnyObject]
            return emojiList
        }
        return nil
    }
}

extension ContactManager {
    /// 联系人排序
    public class var contactArray: [ContactsModel]? {
        guard let seetArray = seetArray else {
            return nil
        }
        
        let groupList = seetArray.map { (model) -> String in
            return model.name.transformToPinyin ?? "#"
        }
        
        // 去重处理
        groupArrasy = groupList.filterDuplicates({ $0 })
        print("groupArrasy------------3434353543-------\(groupArrasy.count)")
        // 排序
        groupArrasy = groupArrasy.sorted(by: { (frist, next) -> Bool in
            return frist < next
        })
        print("groupArrasy--------------23244-----\(groupArrasy.count)")
        return seetArray
    }
}
