//
//  EmojiBottomView.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2021/1/11.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

class EmojiBottomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 44, height: __screenWidth / 8)
        let bottomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(bottomCollectionView)
        bottomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        bottomCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        bottomCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        bottomCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -45).isActive = true
        bottomCollectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "bottomCollectionViewCellId")
        bottomCollectionView.backgroundColor = .darkModeViewColor
        
        return bottomCollectionView
    }()

}
