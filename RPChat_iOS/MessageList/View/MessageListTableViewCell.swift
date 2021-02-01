//
//  MessageListTableViewCell.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/18.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit
import Kingfisher

class MessageListTableViewCell: UITableViewCell {

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

    lazy var headerImg: UIImageView = {
        self.contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    lazy var nickNameLab: UILabel = {
        self.contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: headerImg.rightAnchor, constant: 8).isActive = true
        $0.topAnchor.constraint(equalTo: headerImg.topAnchor, constant: 5).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        $0.font = UIFont(name: "Helvetica-Bold", size: 16.5)
        return $0
    }(UILabel())
    
    lazy var subMessageLab: UILabel = {
        self.contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: headerImg.rightAnchor, constant: 8).isActive = true
        $0.bottomAnchor.constraint(equalTo: headerImg.bottomAnchor, constant: -3).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 17).isActive = true
        $0.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -95).isActive = true
        $0.textColor = .subTextColor
        $0.font = UIFont.systemFont(ofSize: 15)
        return $0
    }(UILabel())
    
    lazy var timeLab: UILabel = {
        self.contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: nickNameLab.topAnchor, constant: 0).isActive = true
        $0.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        $0.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.textColor = .subTextColor
        return $0
    }(UILabel())
    
    lazy var badgeValueView: UIView = {
        self.contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.bottomAnchor.constraint(equalTo: headerImg.bottomAnchor, constant: 0).isActive = true
        $0.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        $0.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.backgroundColor = .red
        return $0
    }(UIView())
    
    lazy var badgeValueLab: UILabel = {
        badgeValueView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: badgeValueView.topAnchor, constant: 0).isActive = true
        $0.leftAnchor.constraint(equalTo: badgeValueView.leftAnchor, constant: 5).isActive = true
        $0.rightAnchor.constraint(equalTo: badgeValueView.rightAnchor, constant: -5).isActive = true
        $0.bottomAnchor.constraint(equalTo: badgeValueView.bottomAnchor, constant: 0).isActive = true
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 12.5)
        return $0
    }(UILabel())
}

extension MessageListTableViewCell {
    /// Message list
    func configMessageListData(_ model: MessageModel) {
//        if model.photo.isEmpty == false {
//            let imgUrl: URL = URL(string: model.photo)!
//            headerImg.kf.setImage(with: imgUrl, placeholder:UIImage(named: "houyi"))
//        } else {
//            headerImg.image = UIImage(named: model.photo)
//        }
        headerImg.image = UIImage(named: model.photo)
        nickNameLab.text = model.userName
        subMessageLab.text = model.lastMsg
        timeLab.text = CurrentTime.fetchTimeInterval(model.createTime)
        
        badgeValueLab.text = "1"
    }
}
