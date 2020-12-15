//
//  AddressBookViewModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation
import RxSwift

public class AddressBookViewModel: PublicViewModel {
    public let addressBookArray: [AddressBookModel] = [AddressBookModel]()
    public let addressBookSubject : PublishSubject<[AddressBookModel]> = PublishSubject()
}
