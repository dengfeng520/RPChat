//
//  RightChatTableViewCell.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/6.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit
import RPChatUIKit

class RightChatTableViewCell: ChatTableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configSendUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSendUI() {
        headerImg.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        
        nickeNameLab.rightAnchor.constraint(equalTo: headerImg.leftAnchor, constant: -8).isActive = true
        nickeNameLab.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        nickeNameLab.textAlignment = .right
        
        messageRootView.rightAnchor.constraint(equalTo: rightTriangleView.leftAnchor, constant: 0).isActive = true
        messageRootView.backgroundColor = .hexStringToColor("0xF5BE62")
        
        loadingView.rightAnchor.constraint(equalTo: messageRootView.leftAnchor, constant: -4).isActive = true
    }
    
    func configChatMessage(_ model: ChatBodyModel) {
        headerImg.setImage(UIImage.init(named: "houyi"), for: .normal)
//        nickeNameLab.text = model.fromUserName
        nickeNameLab.text = "半神之弓"
        messageLab.text = model.msg
    }
    
}
