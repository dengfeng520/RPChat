//
//  AddressBookViewController.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/11.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit
import RxSwift
import MJRefresh
import RPBannerView

class ContactsViewController: BaseChatListViewController {
    
    let viewModel: ContactsViewModel = ContactsViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hiddenBackTitle()
        title = NSLocalizedString("Contacts", comment: "")
        bindViewModel()
    }
    
    lazy var searchBar: UISearchBar = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        let top = $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        let left = $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        let right = $0.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        let heigt = $0.heightAnchor.constraint(equalToConstant: 55)
        NSLayoutConstraint.activate([top, left, right, heigt])
        $0.delegate = self
        return $0
    }(UISearchBar())
}


