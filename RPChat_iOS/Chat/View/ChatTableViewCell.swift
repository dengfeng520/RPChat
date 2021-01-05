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
    private var leftLayout: NSLayoutConstraint!
    private var rightLayout: NSLayoutConstraint!
    
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
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 头像
    lazy var headerImg: UIButton = {
        contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.imageView?.contentMode = .scaleAspectFill
        return $0
    }(UIButton())
    /// 昵称
    lazy var nickeNameLab: UILabel = {
        contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return $0
    }(UILabel())
    /// 左气泡
    lazy var leftTriangleView: ChatLeftTriangleView = {
        messageRootView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: nickeNameLab.bottomAnchor, constant: 12).isActive = true
        $0.leftAnchor.constraint(equalTo: headerImg.rightAnchor, constant: 5).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 5).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 13).isActive = true
        $0.backgroundColor = .darkModeViewColor
        return $0
    }(ChatLeftTriangleView())
    /// 右气泡
    lazy var rightTriangleView: ChatRightTriangleView = {
        messageRootView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: nickeNameLab.bottomAnchor, constant: 12).isActive = true
        $0.rightAnchor.constraint(equalTo: headerImg.leftAnchor, constant: -5).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 5).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 13).isActive = true
        $0.backgroundColor = .darkModeViewColor
        return $0
    }(ChatRightTriangleView())
    /// root view
    lazy var messageRootView: UIView = {
        contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: nickeNameLab.bottomAnchor, constant: 7).isActive = true
        $0.heightAnchor.constraint(greaterThanOrEqualToConstant: 35).isActive = true
        $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        $0.widthAnchor.constraint(greaterThanOrEqualToConstant: 35).isActive = true
        $0.widthAnchor.constraint(lessThanOrEqualToConstant: __screenWidth - 110).isActive = true
        $0.layer.cornerRadius = 4
        $0.backgroundColor = .subViewColor
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
        $0.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    /// loading
    lazy var loadingView: UIActivityIndicatorView = { [weak self] in
        messageRootView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.centerYAnchor.constraint(equalTo: messageRootView.centerYAnchor, constant: 0).isActive = true
        $0.startAnimating()
        return $0
    }(UIActivityIndicatorView())
}

extension ChatTableViewCell {
    func cofigLeftChatMessage(_ model: ChatBodyModel) {
        configReceivedUI()
        headerImg.setImage(UIImage.init(named: "sunshangxiang"), for: .normal)
        nickeNameLab.text = model.fromUserName
        messageLab.text = model.msg
    }
    
    func configRightChatMessage(_ model: ChatBodyModel) {
        configSendUI()
        
        headerImg.setImage(UIImage.init(named: "jialuo"), for: .normal)
        nickeNameLab.text = model.fromUserName
        messageLab.text = model.msg
    }
}

extension ChatTableViewCell {
    private func configReceivedUI() {
        
        headerImg.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        
        nickeNameLab.leftAnchor.constraint(equalTo: headerImg.rightAnchor, constant: 8).isActive = true
        nickeNameLab.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        
        if let rightLayout = rightLayout {
            messageRootView.removeConstraint(rightLayout)
        }
        leftLayout = messageRootView.leftAnchor.constraint(equalTo: leftTriangleView.rightAnchor, constant: 0)
        leftLayout.isActive = true
        messageRootView.backgroundColor = .subViewColor
            
        loadingView.leftAnchor.constraint(equalTo: messageRootView.rightAnchor, constant: 4).isActive = true
    }
    
    private func configSendUI() {
        
        leftTriangleView.removeFromSuperview()
        headerImg.removeFromSuperview()
        nickeNameLab.removeFromSuperview()
        messageRootView.removeFromSuperview()
        loadingView.removeFromSuperview()
        
        headerImg.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        
        nickeNameLab.rightAnchor.constraint(equalTo: headerImg.leftAnchor, constant: -8).isActive = true
        nickeNameLab.leftAnchor.constraint(equalTo: contentView.rightAnchor, constant: 12).isActive = true
        
        if let leftLayout = leftLayout {
            print("remove=============left")
            messageRootView.removeConstraint(leftLayout)
        }
        rightLayout = messageRootView.rightAnchor.constraint(equalTo: rightTriangleView.leftAnchor, constant: 0)
        rightLayout.isActive = true
        messageRootView.backgroundColor = .hexStringToColor("0xF5BE62")
        
        loadingView.rightAnchor.constraint(equalTo: messageRootView.leftAnchor, constant: -4).isActive = true
    }
}
