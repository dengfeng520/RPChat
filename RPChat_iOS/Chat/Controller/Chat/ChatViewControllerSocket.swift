//
//  ChatViewControllerSocket.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/22.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift

extension ChatViewController {
    func bindSocketAbout() {
        // 收到消息
        socket.receiveServrerMessageSubject.subscribe(onNext: { messageBody in
            
        }).disposed(by: disposeBag)
    }
}
