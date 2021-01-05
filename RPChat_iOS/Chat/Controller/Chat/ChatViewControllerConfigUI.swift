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
import RPChatDataKit

extension ChatViewController: UITableViewDelegate {
    func bindViewModel() {
        title = viewModel.friendsModel.userName
        // loading
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        // fetch chat list
        configChatArrayData()
        // subject
        viewModel.chatListSubject.bind(to: tableView.rx.items(cellIdentifier: "ChatTableViewCellId", cellType: ChatTableViewCell.self)) { [weak self] (row, model, cell) in
            guard let `self` = self else { return }
            cell.headerImg.tag = row
            cell.headerImg.rx.tap.subscribe(onNext: {
                self.prentsFriendInfoVC(model)
            }).disposed(by: self.disposeBag)
            if row % 2 == 0 {
                cell.cofigLeftChatMessage(model)
            } else {
                cell.configRightChatMessage(model)
            }
            
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
    
    private func prentsFriendInfoVC(_ model: ChatBodyModel) {
        let friendInfoVC = FriendInfoViewController()
        self.navigationController?.present(friendInfoVC, animated: true, completion: {
            
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}


extension ChatViewController {
    func configChatArrayData() {
        var parameter = [String : String]()
        if viewModel.friendsModel.type == "1" {
            parameter = ["type":"\(viewModel.friendsModel.type)",
                         "userId":"\(viewModel.friendsModel.userId)",
                         "pageSize":"20",
                         "pageIndex":"\(1)"]
        } else {
            parameter = ["type":"\(viewModel.friendsModel.type)",
                         "groupId":"\(viewModel.friendsModel.userId)",
                         "pageSize":"20",
                         "pageIndex":"\(1)"]
        }
        print("parameter-------------\(parameter)")
        viewModel.fetchChatList(parameter)
    }
}
