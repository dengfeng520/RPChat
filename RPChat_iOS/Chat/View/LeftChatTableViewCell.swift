//
//  LeftChatTableViewCell.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/6.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit

class LeftChatTableViewCell: ChatTableViewCell {

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
        
        configReceivedUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configReceivedUI() {
        headerImg.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        
        nickeNameLab.leftAnchor.constraint(equalTo: headerImg.rightAnchor, constant: 8).isActive = true
        nickeNameLab.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        
       messageRootView.leftAnchor.constraint(equalTo: leftTriangleView.rightAnchor, constant: 0).isActive = true
        messageRootView.backgroundColor = .subViewColor
            
        loadingView.leftAnchor.constraint(equalTo: messageRootView.rightAnchor, constant: 4).isActive = true
    }
    
   func configChatMessage(_ model: ChatBodyModel) {
        headerImg.setImage(UIImage.init(named: "sunshangxiang"), for: .normal)
        nickeNameLab.text = model.fromUserName
        messageLab.text = model.msg
    }

}
