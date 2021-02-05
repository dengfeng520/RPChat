//
//  DownloadImageViewController.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/2/3.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit
import RPChatUIKit
import RxSwift
import RxCocoa

class DownloadImageViewController: QueueBaseViewController {
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenBackTitle()
        // Do any additional setup after loading the view.
        title = NSLocalizedString("Async Loading Images", comment: "")
        bindData()
        fpsLab.isHidden = false
    }
    
    lazy var tableView: UITableView = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        $0.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        $0.rowHeight = 180
        $0.separatorStyle = .none
        $0.backgroundColor = .groupedColor
        $0.register(DownloadImageTableViewCell.self, forCellReuseIdentifier: "DownloadImageTableViewCellId")
        return $0
    }(UITableView())
    
    
    
    private func bindData() {
        let item = Observable<[String]>.just(DownloaderManager.imageArray)
        item.bind(to: tableView.rx.items(cellIdentifier: "DownloadImageTableViewCellId", cellType: DownloadImageTableViewCell.self)) { (row, imgurl, cell) in
            cell.configImageWith(imgurl)
        }.disposed(by: disposeBag)
        
        // delegate
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension DownloadImageViewController: UITableViewDelegate {
    
}
