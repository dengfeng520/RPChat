//
//  ChatTableViewCell.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/15.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatUIKit
import RPChatDataKit

class ChatTableViewCell: UITableViewCell, ChatCellProtocol {
    var stype: mineOrOtherMode?
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 头像
    lazy var headerImg: UIImageView = {
        contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return $0
    }(UIImageView())
    /// 昵称
    lazy var nickeNameLab: UILabel = {
        contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return $0
    }(UILabel())
    /// 左气泡
    lazy var leftTriangleView: ChatLeftTriangleView = {
        messageRootView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: nickeNameLab.bottomAnchor, constant: 25).isActive = true
        $0.leftAnchor.constraint(equalTo: headerImg.rightAnchor, constant: 12).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 13).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return $0
    }(ChatLeftTriangleView())
    /// 右气泡
    lazy var rightTriangleView: ChatLeftTriangleView = {
        messageRootView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: nickeNameLab.bottomAnchor, constant: 25).isActive = true
        $0.rightAnchor.constraint(equalTo: headerImg.leftAnchor, constant: -12).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 13).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return $0
    }(ChatLeftTriangleView())
    /// root view
    lazy var messageRootView: UIView = {
        contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: nickeNameLab.bottomAnchor, constant: 8).isActive = true
        $0.heightAnchor.constraint(greaterThanOrEqualToConstant: 55).isActive = true
        $0.layer.cornerRadius = 4
        return $0
    }(UIView())
    /// 显示消息内容
    lazy var messageLab: UILabel = {
        messageRootView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: messageRootView.topAnchor, constant: 10).isActive = true
        $0.leftAnchor.constraint(equalTo: messageRootView.leftAnchor, constant: 12).isActive = true
        $0.rightAnchor.constraint(equalTo: messageRootView.rightAnchor, constant: -12).isActive = true
        $0.bottomAnchor.constraint(equalTo: messageRootView.bottomAnchor, constant: -10).isActive = true
        $0.heightAnchor.constraint(greaterThanOrEqualToConstant: 35).isActive = true
        $0.numberOfLines = 0
        return $0
    }(UILabel())
}

extension ChatTableViewCell {
    func cofigChatMessage(_ withModel: ChatBodyModel) {
        
    }
}

extension ChatTableViewCell {
    private func configReceivedUI() {
        headerImg.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        
        nickeNameLab.leftAnchor.constraint(equalTo: headerImg.rightAnchor, constant: 8).isActive = true
        nickeNameLab.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        
        messageRootView.leftAnchor.constraint(equalTo: leftTriangleView.rightAnchor, constant: 0).isActive = true
        messageRootView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -95).isActive = true
    }
    
    private func configSendUI() {
        headerImg.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        
        nickeNameLab.rightAnchor.constraint(equalTo: headerImg.leftAnchor, constant: -8).isActive = true
        nickeNameLab.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        
        messageRootView.rightAnchor.constraint(equalTo: leftTriangleView.leftAnchor, constant: 0).isActive = true
        messageRootView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 95).isActive = true
    }
}
