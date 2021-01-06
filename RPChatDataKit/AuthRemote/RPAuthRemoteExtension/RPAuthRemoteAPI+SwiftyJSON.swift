//
//  RPAuthRemoteAPI+SwiftyJSON.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/30.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxSwift

extension RPAuthRemoteAPI {
    /// 调用接口，成功返回JSON -----> RxSwift
    public func post(with body: [String : AnyObject], _ path: String) -> Observable<JSON> {
        
        return Observable.create { (observer) -> Disposable in
           
            return Disposables.create {  }
        }
    }
}

