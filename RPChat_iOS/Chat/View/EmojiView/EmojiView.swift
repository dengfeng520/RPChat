//
//  EmojiView.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/7.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPChatDataKit
import QuartzCore
import RPChatUIKit

class EmojiView: UIView {
    let disposeBag: DisposeBag = DisposeBag()
    var emojiArray: [EmojiModel] = [EmojiModel]()
    let selectEmojiSub: PublishSubject<String> = PublishSubject()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configEmojiUI()
        
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configEmojiUI() {
        if let emoji = EmojiManager.emojiNameArray {
            emojiArray = emoji
            emojiCollectionView.reloadData()
        }
        deleteBtn.setImage(UIImage(named: "emoji_delete"), for: .normal)
        deleteBtn.setImage(UIImage(named: "emoji_delete_select"), for: .selected)
        deleteBtn.rx.tap.subscribe(onNext: {
            
        }).disposed(by: disposeBag)
    }
    
    /// lazy
    lazy var emojiCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: __screenWidth / 8, height: __screenWidth / 8)
        let emojiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(emojiCollectionView)
        emojiCollectionView.translatesAutoresizingMaskIntoConstraints = false
        emojiCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        emojiCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        emojiCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        emojiCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -45).isActive = true
        emojiCollectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "EmojiCollectionViewCellId")
        emojiCollectionView.backgroundColor = .darkModeViewColor    
        return emojiCollectionView
    }()
    
    lazy var deleteBtn: UIButton = {
        self.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -55).isActive = true
        $0.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 28).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 22).isActive = true
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowColor = UIColor.darkModeTextColor.cgColor
        $0.layer.shadowRadius = 2.5
        $0.layer.shadowOffset = CGSize(width: 1, height: 1)
        $0.backgroundColor = .subViewColor
        $0.layer.cornerRadius = 3
        return $0
    }(UIButton())
}


extension EmojiView {
    func setupBinding() {
        let item = Observable.just(emojiArray)
        item.bind(to: emojiCollectionView.rx.items(cellIdentifier: "EmojiCollectionViewCellId", cellType: EmojiCollectionViewCell.self)) { (row, model, cell) in
            cell.converEmoji(model)
        }.disposed(by: disposeBag)
        
        //获取选中项的索引
        emojiCollectionView.rx.itemSelected.subscribe(onNext: { indexPath in

        }).disposed(by: disposeBag)

        //获取选中项的内容
        emojiCollectionView.rx.modelSelected(String.self).subscribe(onNext: { item in

        }).disposed(by: disposeBag)
    }
}
