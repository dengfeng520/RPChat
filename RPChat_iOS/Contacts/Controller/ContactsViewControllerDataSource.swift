//
//  ContactsViewControllerDataSource.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/27.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RPBannerView
import RPChatDataKit

extension ContactsViewController {
    func bindViewModel() {
        // loading
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        // 获取数据
        viewModel.fetchContactsList()
        // subject
        viewModel.contactsSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (contacts) in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        // error
        viewModel.errorSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
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
}

extension ContactsViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.contactsArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactsArray[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCellId", for: indexPath) as! ContactsTableViewCell
        let list = viewModel.contactsArray[indexPath.section]
        cell.configContactsData(list[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if viewModel.contactsArray.count != 0 {
            let list: [ContactsModel] = viewModel.contactsArray[section]
            return list.first?.name.transformToPinyin
        } else {
            return "#"
        }
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.contactsArray.compactMap {
           return $0.first?.name.transformToPinyin
        }
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let model = viewModel.contactsArray[indexPath.section][indexPath.row]
        let friendsInfoVC = FriendInfoViewController()
        friendsInfoVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(friendsInfoVC, animated: true)
    }
}
