//
//  ChatTableViewCellFactory.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/17.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

struct ChatTableViewCellFactory {
    static func createCell(mode: mineOrOtherMode, tableView: UITableView, indexPath: IndexPath) -> ChatCellProtocol? {
        if mode == .mineMode {
            let cell: ChatRightTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCellId") as! ChatRightTableViewCell
            
            return cell
        } else {
            let cell: ChatLeftTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCellId") as! ChatLeftTableViewCell
            
            return cell
        }
    }
}
