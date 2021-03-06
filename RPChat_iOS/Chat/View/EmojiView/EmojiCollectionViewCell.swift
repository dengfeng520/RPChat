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
    
    private var emojiImgWidth: NSLayoutConstraint!
    private var emojiImgHeight: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkModeViewColor
        contentView.layer.cornerRadius = 3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var emojiImg: UIImageView = {
        contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        emojiImgWidth = $0.widthAnchor.constraint(equalToConstant: 35)
        emojiImgWidth.isActive = true
        emojiImgHeight = $0.heightAnchor.constraint(equalToConstant: 35)
        emojiImgHeight.isActive = true
        return $0
    }(UIImageView())
    
    
    /// emoji
    func converEmoji(_ model: EmojiModel) {
        if model.isCache == true {
            emojiImg.image = UIImage(named: "\(model.face_name)")
        } else {
            let img = EmojiManager.fetchEmojiImage("\(model.face_name)@2x")
            emojiImg.image = img
        }
    }
    
    func converSystemEmoji(_ name: String) {
        let img = EmojiManager.fetchEmojiImage("\(name)@2x")
        emojiImg.image = img
    }
    
    /// 自定义表情包
    func converCustomizeEmoji(_ name: String) {
        
        emojiImg.image = UIImage(named: name)
    }
}
