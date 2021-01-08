//
//  ChatTableViewCell.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/15.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RPChatUIKit
import RPChatDataKit

class ChatTableViewCell: UITableViewCell, ChatCellProtocol {
    
    let disposeBag: DisposeBag = DisposeBag()
    public var headerTapClosures: (() -> Void)?
    
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
        contentView.backgroundColor = .groupedColor
        
        /// 添加点击事件
        headerImg.rx.tap.subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            if let headerTapClosures = self.headerTapClosures {
                headerTapClosures()
            }
        }).disposed(by: disposeBag)
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
        $0.font = UIFont(name: "Helvetica-Bold", size: 12)
        $0.textColor = .subTextColor
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
        $0.backgroundColor = .groupedColor
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
        $0.backgroundColor = .groupedColor
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

