//
//  AuthRemoteProtocol.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/12/30.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import PromiseKit
import SwiftyJSON
import RxSwift

public protocol AuthRemoteProtocol {
    /// 调用接口，成功返回JSON -----> PromiseKit
    func post(with body: [String : AnyObject], _ path: String) -> Promise<JSON>
    /// 调用接口，成功返回JSON -----> RxSwift
    func post(with body: [String : AnyObject], _ path: String) -> Observable<JSON>
    /// 协议方式，成功返回JSON -----> RxSwift
    func post<T: Request>(_ r: T) -> Observable<JSON>
    /// 协议方式，成功返回JSON -----> RxSwift
    func requestData<T: Request>(_ r: T) -> Observable<JSON>
    // TODO: 调用接口，成功返回JSON ----->  Closures
    func post<T: Request>(_ r: T, with closures: @escaping ((_ json: JSON,_ failure : String?) -> Void))
}

extension AuthRemoteProtocol {
    // 可选
    public func post<T: Request>(_ r: T, with closures: @escaping ((_ json: JSON,_ failure : String?) -> Void)) { }
}
