//
//  UITabBarControllerExtension.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/11.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift

open class UITabBarControllerExtension: UITabBarController {
    
    let messageListNav = UINavigationController(rootViewController: MessageListViewController())
    let addressBookNav = UINavigationController(rootViewController: AddressBookViewController())
    let discoverNav = UINavigationController(rootViewController: DiscoverViewController())
    let mineNav = UINavigationController(rootViewController: MineViewController())
    
    open override func viewDidLoad() {
        super.viewDidLoad()
         
        let imageList: [String] = ["unselect_message_icon","unselect_address_book","unselect_find_icon","unselect_mine_icon"]
        let selectImageList: [String] = ["message_icon","address_book","find_icon","mine_icon"]
        // BradleyHandITCTT-Bold
        messageListNav.tabBarItem = UITabBarItem(title: NSLocalizedString("Chats", comment: ""), image: UIImage(named: imageList[0]), selectedImage: UIImage(named: selectImageList[0]))
        addressBookNav.tabBarItem = UITabBarItem(title: NSLocalizedString("Contacts", comment: ""), image: UIImage(named: imageList[1]), selectedImage: UIImage(named: selectImageList[1]))
        discoverNav.tabBarItem = UITabBarItem(title: NSLocalizedString("Discover", comment: ""), image: UIImage(named: imageList[2]), selectedImage: UIImage(named: selectImageList[2]))
        mineNav.tabBarItem = UITabBarItem(title: NSLocalizedString("Me", comment: ""), image: UIImage(named: imageList[3]), selectedImage: UIImage(named: selectImageList[3]))
        
        messageListNav.tabBarItem.badgeValue = "10"
        
        viewControllers = [messageListNav, addressBookNav, discoverNav ,mineNav]

        tabBar.tintColor = .white
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = .configSubViewColorWith(.hexStringToColor("0xF5BE62"))
    }
}
