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
    
    lazy var customizeEmojiArray = [[EmojiModel]]()
    let disposeBag: DisposeBag = DisposeBag()
    
    let tapBottomEmojiChangeSub: PublishSubject? = PublishSubject<Int>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        if let list = EmojiManager.fetchEmoticonsList {
            customizeEmojiArray = list
            setupBinding()
            bottomCollectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var addEmojiBtn: UIButton = {
        addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        $0.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 28).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 28).isActive = true
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
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.setTitle(NSLocalizedString("Send", comment: ""), for: .normal)
        $0.setTitleColor(.white, for: .normal)
       return $0
    }(UIButton())
    
    lazy var bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 45, height: 38)
        let bottomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(bottomCollectionView)
        bottomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomCollectionView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 0).isActive = true
        bottomCollectionView.leftAnchor.constraint(equalTo: addEmojiBtn.rightAnchor, constant: 8).isActive = true
        bottomCollectionView.rightAnchor.constraint(equalTo: sendEmojiBtn.leftAnchor, constant: -45).isActive = true
        bottomCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        bottomCollectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "bottomCollectionViewCellId")
        bottomCollectionView.backgroundColor = .darkModeViewColor
        bottomCollectionView.showsHorizontalScrollIndicator = false
        return bottomCollectionView
    }()
    
    lazy var lineView: UIView = {
        addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        $0.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        $0.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 1).isActive = true
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowColor = UIColor.subViewColor.cgColor
        $0.layer.shadowRadius = 1
        $0.layer.shadowOffset = CGSize(width: 1, height: 0.5)
        $0.backgroundColor = .subViewColor
        return $0
    }(UIView())
}

extension EmojiBottomView: UICollectionViewDelegate {
    func setupBinding() {
        let list: [String] = customizeEmojiArray.compactMap { (subList) -> String in
            return subList.first?.face_name ?? String()
        }
        let item = Observable<[String]>.just(list)
        item.bind(to: bottomCollectionView.rx.items(cellIdentifier: "bottomCollectionViewCellId", cellType: EmojiCollectionViewCell.self)) { (row, emojiName, cell) in
            if row == 0 {
                cell.converSystemEmoji(emojiName)
            } else {
                cell.converCustomizeEmoji(emojiName)
            }
        }.disposed(by: disposeBag)
        // 默认选中第一个item
        let indexPath = IndexPath(row: 0, section: 0)
        bottomCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
        // 获取选中项的索引
        bottomCollectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let `self` = self else { return }
            if let tapBottomEmojiChangeSub = self.tapBottomEmojiChangeSub {
                tapBottomEmojiChangeSub.onNext(indexPath.row)
            }
            let cell: EmojiCollectionViewCell = self.bottomCollectionView.cellForItem(at: indexPath) as! EmojiCollectionViewCell
            cell.contentView.backgroundColor = .subViewColor
        }).disposed(by: disposeBag)
        // 取消选中
        bottomCollectionView.rx.itemDeselected.subscribe(onNext: { [weak self] indexPath in
            guard let `self` = self else { return }
            let cell: EmojiCollectionViewCell = self.bottomCollectionView.cellForItem(at: indexPath) as! EmojiCollectionViewCell
            cell.contentView.backgroundColor = .darkModeViewColor
        }).disposed(by: disposeBag)
        // delegate
        bottomCollectionView.rx.setDelegate(self).disposed(by: disposeBag)

    }
}
