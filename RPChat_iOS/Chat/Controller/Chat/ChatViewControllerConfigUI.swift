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
        viewModel.receiveChatSubject.subscribe(onNext: { [weak self] (chatList) in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        // error
        viewModel.errorSubject.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
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
        // dataSource
        tableView.rx.setDataSource(self).disposed(by: disposeBag)
    }
    
    private func prentsFriendInfoVC(_ model: ChatBodyModel) {
        let friendInfoVC = FriendInfoViewController()
        self.navigationController?.present(friendInfoVC, animated: true, completion: {
            
        })
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("receiveChatArray.count===========\(viewModel.receiveChatArray.count)")
        return viewModel.receiveChatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatTableViewCell = ChatCellShopFactory.createCell(model: viewModel.receiveChatArray[indexPath.row], tableView: tableView, indexPath: indexPath) as! ChatTableViewCell
        
        cell.headerImg.rx.tap.subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            self.prentsFriendInfoVC(self.viewModel.receiveChatArray[indexPath.row])
        }).disposed(by: self.disposeBag)
        
        return cell
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
