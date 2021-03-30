//
//  BaseChatListViewController.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/15.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

class BaseChatListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    lazy var tableView: UITableView = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        let top = $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        let left = $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        let width = $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        let bottom = $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([top, left, width, bottom])
        $0.separatorStyle = .none
        $0.register(ContactsTableViewCell.self, forCellReuseIdentifier: "ContactsTableViewCellId")
        $0.sectionIndexColor = .subTextColor
        return $0
    }(UITableView())
}

extension BaseChatListViewController {
    
}
