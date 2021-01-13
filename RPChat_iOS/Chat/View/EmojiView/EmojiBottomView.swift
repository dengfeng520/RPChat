//
//  EmojiBottomView.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2021/1/11.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatUIKit
import RPChatDataKit
import RxSwift

class EmojiBottomView: UIView {
    
    lazy var customizeEmojiArray = [[String]]()
    let disposeBag: DisposeBag = DisposeBag()
    let tapBottomEmojiChangeSub: PublishSubject? = PublishSubject<Int>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        if let list = EmojiManager.fetchCustomizeEmojiList {
//            customizeEmojiArray = list
//            bottomCollectionView.reloadData()
//        }
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var addEmojiBtn: UIButton = {
        addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        $0.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 32).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.setImage(UIImage.init(named: "add_emoji"), for: .normal)
        return $0
    }(UIButton())
    
    lazy var sendEmojiBtn: UIButton = {
        addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        $0.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 25).isActive = true
        $0.layer.cornerRadius = 3
        $0.layer.backgroundColor = UIColor.themeColor.cgColor
        $0.setTitle(NSLocalizedString("Send", comment: ""), for: .normal)
        $0.setTitleColor(.white, for: .normal)
       return $0
    }(UIButton())
    
    lazy var bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 44, height: __screenWidth / 8)
        let bottomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(bottomCollectionView)
        bottomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        bottomCollectionView.leftAnchor.constraint(equalTo: addEmojiBtn.rightAnchor, constant: -5).isActive = true
        bottomCollectionView.rightAnchor.constraint(equalTo: sendEmojiBtn.leftAnchor, constant: -5).isActive = true
        bottomCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -45).isActive = true
        bottomCollectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "bottomCollectionViewCellId")
        bottomCollectionView.backgroundColor = .darkModeViewColor
        
        return bottomCollectionView
    }()
}

extension EmojiBottomView {
    func setupBinding() {
        let list: [String] = customizeEmojiArray.compactMap { (subList) -> String in
            return subList.first ?? String()
        }
        let item = Observable.just(list)
        item.bind(to: bottomCollectionView.rx.items(cellIdentifier: "bottomCollectionViewCellId", cellType: EmojiCollectionViewCell.self)) { (row, emojiName, cell) in
            cell.converCustomizeEmoji(emojiName)
        }.disposed(by: disposeBag)
        // 获取选中项的索引
        bottomCollectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let `self` = self else { return }
            if let tapBottomEmojiChangeSub = self.tapBottomEmojiChangeSub {
                tapBottomEmojiChangeSub.onNext(indexPath.row)
            }
        }).disposed(by: disposeBag)
    }
}
