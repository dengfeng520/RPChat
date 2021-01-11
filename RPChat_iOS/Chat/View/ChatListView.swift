//
//  ChatListView.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/11.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift

class ChatListView: UITableView {
    /// 是否在最底部
    var currentIsInBottom: Bool = false
    /// 是否在滚动中
    var scrollStatus: Bool = false
    let disposeBag: DisposeBag = DisposeBag()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
//        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatListView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let bottomOffset = scrollView.contentSize.height - scrollView.contentOffset.y
        if bottomOffset <= height {
            currentIsInBottom = true
        } else {
            currentIsInBottom = false
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollStatus = decelerate
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollView------------------1212121212")
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("scrollView------------------13131313131")
    }
    
}
