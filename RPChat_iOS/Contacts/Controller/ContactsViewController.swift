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
}


