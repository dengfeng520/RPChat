//
//  ConversatListViewModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/18.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift

public class ConversatListViewModel: PublicViewModel {
    public var conversatListArray: [ConversatModel] = [ConversatModel]()
    public let conversatListSubject : PublishSubject<[ConversatModel]> = PublishSubject()
    
    public override init() {
        super.init()
    }

    public func fetchChatList() {
        self.loading.onNext(true)
        HTTPRequest().authRemoteAPIWith(ChatListWithRequest(parameter: [:])) { [weak self] (result) in
            guard let `self` = self else { return }
            self.loading.onNext(false)
            switch result {
            case .success(let returnJson) :
                if returnJson["returnCode"].intValue == 601 {
                    self.error.onNext(returnJson["returnMsg"].stringValue)
                } else if returnJson["returnCode"].intValue == 201 {
                    self.error.onNext(returnJson["returnMsg"].stringValue)
                } else {
                    self.conversatListArray = returnJson["data"].arrayValue.map({ (json) -> ConversatModel in
                        return ConversatModel(json: json)
                    })
                    self.conversatListSubject.onNext(self.conversatListArray)
                }
                break
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self.error.onNext(NSLocalizedString("Request Timed Out", comment: ""))
                    break
                case .authorizationError(let errorJson):
                    self.error.onNext(errorJson["returnMsg"].stringValue)
                    break
                case .statusCodeError(let errorJson):
                    self.error.onNext(errorJson["returnMsg"].stringValue)
                    break
                case .unknownError:
                    self.error.onNext(NSLocalizedString("Unknown Error", comment: ""))
                    break
                case .isAlert(let errorJson):
                    self.error.onNext(errorJson["returnMsg"].stringValue)
                    break
                default :
                    self.error.onNext(NSLocalizedString("Unknown Error", comment: ""))
                    break
                }
            }
        }
    }
}
