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
        $0.widthAnchor.constraint(equalToConstant: 28).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 28).isActive = true
        return $0
    }(UIImageView())
    
    
    func converEmoji(_ model: EmojiModel) {
        emojiImg.image = UIImage.init(named: "\(model.face_name)@2x")
    }
}
