//
//  MessageListViewController.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/8/26.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit
import RPChatUIKit
import RxSwift
import RPBannerView

class MessageListViewController: BaseChatListViewController {

    let viewModel: ConversatListViewModel = ConversatListViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
        title = NSLocalizedString("Message List", comment: "")
        
    }

    private func configUI() {
        view.backgroundColor = .darkModeViewColor
        
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
    }
}

extension MessageListViewController: UITableViewDelegate {
    func bindViewModel() {
        // loading
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        // subject
        viewModel.conversatListSubject.bind(to: tableView.rx.items(cellIdentifier: "AddressBookTableViewCellId", cellType: AddressBookTableViewCell.self)) { (row, model, cell) in
            
        }.disposed(by: disposeBag)
        // error
        viewModel.error.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
            guard let `self` = self else { return }
            RPBannerView.showBanner(BannerDisplay(title: error ,backColor: .red, addView: self.view ,time: 0, mode: .mobileMode))
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
        return 60
    }
}
