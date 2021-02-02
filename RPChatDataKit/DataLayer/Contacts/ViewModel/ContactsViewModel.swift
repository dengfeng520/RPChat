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
    public var contactsArray: [[ContactsModel]] = [[ContactsModel]]()
    public let contactsSubject : PublishSubject<[[ContactsModel]]> = PublishSubject()
    
    public var searchArray: [[ContactsModel]] = [[ContactsModel]]()
    
    public func fetchContactsList() {
        /// 模拟网络请求
        self.loading.onNext(true)
        RPAuthRemoteAPI().requestData(FriendsListWithRequest(parameter: ["groupId":""] as [String : AnyObject]))
            .subscribe(onNext: { [weak self] returnJson in
                guard let `self` = self else { return }
                if let list: [[ContactsModel]] = ContactManager.contactArray {
                    self.contactsArray = list
                    print("self.groupArray-------------------\(self.contactsArray)")
                    self.contactsSubject.onNext(list)
                } else {
                    self.errorSubject.onNext(NSLocalizedString("Unknown Error", comment: ""))
                }
            }, onError: { errorJson in
                self.errorSubject.onNext(NSLocalizedString("Unknown Error", comment: ""))
                self.loading.onNext(false)
            }, onCompleted: {
                self.loading.onNext(false)
            }).disposed(by: disposeBag)
    }
}
