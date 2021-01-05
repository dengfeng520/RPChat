//
//  AddressBookViewModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation
import RxSwift

public class ContactsViewModel: PublicViewModel {
    public let addressBookArray: [ContactsModel] = [ContactsModel]()
    public let addressBookSubject : PublishSubject<[ContactsModel]> = PublishSubject()
    
    public func fetchAddressBookList() {
        
    }
}
