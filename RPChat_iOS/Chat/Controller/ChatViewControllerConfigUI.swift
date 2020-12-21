//
//  ChatViewControllerConfigUI.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/15.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RPBannerView

extension ChatViewController: UITableViewDelegate {
    func bindViewModel() {
        // loading
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        // subject
        viewModel.chatListSubject.bind(to: tableView.rx.items(cellIdentifier: "ChatTableViewCellId", cellType: ChatTableViewCell.self)) { (row, model, cell) in
            cell.cofigChatMessage(model)
        }.disposed(by: disposeBag)
        // error
        viewModel.error.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
            guard let `self` = self else { return }
            RPBannerView.show(with: .perfectionMode, body: error, isView: self.view)
        }).disposed(by: disposeBag)
        // selected
        tableView.rx.itemSelected.bind { [weak self] (indexPath) in
            guard let `self` = self else { return }
            self.tableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)
        // delegate
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}


extension ChatViewController {
    func configChatDataWith() {
        var parameter = [String : String]()
        if friendsModel.type == "1" {
            parameter = ["type":"\(friendsModel.type)",
                "userId":"\(friendsModel.userId)",
                "pageSize":"20",
                "pageIndex":"\(1)"]
        } else {
            parameter = ["type":"\(friendsModel.type)",
                "groupId":"\(friendsModel.userId)",
                "pageSize":"20",
                "pageIndex":"\(1)"]
        }
        viewModel.fetchChatList(parameter)
    }
}
