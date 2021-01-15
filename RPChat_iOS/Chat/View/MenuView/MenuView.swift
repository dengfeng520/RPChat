//
//  MenuView.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/14.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuView: UIView {
    let disposeBag: DisposeBag = DisposeBag()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 45, height: 38)
        let menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(menuCollectionView)
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        menuCollectionView.topAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        menuCollectionView.leftAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
        menuCollectionView.rightAnchor.constraint(equalTo: leftAnchor, constant: -45).isActive = true
        menuCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        menuCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "menuCollectionViewCellId")
        menuCollectionView.backgroundColor = .darkModeViewColor
        menuCollectionView.showsHorizontalScrollIndicator = false
        return menuCollectionView
    }()
    
}

extension MenuView: UICollectionViewDelegate {
    func setupBinding() {
        let item = Observable<[String]>.just([])
        item.bind(to: menuCollectionView.rx.items(cellIdentifier: "menuCollectionViewCellId", cellType: MenuCollectionViewCell.self)) { (row, emojiName, cell) in
            
        }.disposed(by: disposeBag)
        // 获取选中项的索引
        menuCollectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let `self` = self else { return }
            let cell: MenuCollectionViewCell = self.menuCollectionView.cellForItem(at: indexPath) as! MenuCollectionViewCell
            cell.contentView.backgroundColor = .subViewColor
        }).disposed(by: disposeBag)
        // 取消选中
        menuCollectionView.rx.itemDeselected.subscribe(onNext: { [weak self] indexPath in
            guard let `self` = self else { return }
            let cell: MenuCollectionViewCell = self.menuCollectionView.cellForItem(at: indexPath) as! MenuCollectionViewCell
            cell.contentView.backgroundColor = .darkModeViewColor
        }).disposed(by: disposeBag)
        // delegate
        menuCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}
