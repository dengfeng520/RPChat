//
//  ChatCellShopFactory.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/6.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit

protocol ShopGoodsProtocol {
    
}

struct ChatCellShopFactory {
    var stype: mineOrOtherMode?

    static func createCell(model: ChatBodyModel, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        if indexPath.row % 2 == 0 {
            let cell: LeftChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LeftChatTableViewCellId", for: indexPath) as! LeftChatTableViewCell
            cell.configChatMessage(model)
            return cell
        } else {
            let cell: RightChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RightChatTableViewCellId", for: indexPath) as! RightChatTableViewCell
            cell.configChatMessage(model)
            return cell
        }
    }
}
