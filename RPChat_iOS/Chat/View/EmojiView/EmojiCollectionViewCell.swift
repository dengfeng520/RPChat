//
//  EmojiCollectionViewCell.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2021/1/8.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit

class EmojiCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .darkModeViewColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var emojiImg: UIImageView = {
        contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 32).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return $0
    }(UIImageView())
    
    lazy var interestingEmojiImg: UIImageView = {
        contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return $0
    }(UIImageView())
    
    /// IM 自带的表情
    func converEmoji(_ model: EmojiModel) {
        let img = EmojiManager.fetchEmojiImage("\(model.face_name)@2x")
        emojiImg.image = img
    }
    /// 自定义表情包
    func converCustomizeEmoji(_ name: String) {
        interestingEmojiImg.image = UIImage(named: name)
    }
}
