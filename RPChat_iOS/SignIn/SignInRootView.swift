//
//  SignInRootView.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/6/16.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPChatUIKit
import RPChatDataKit

class SignInRootView: NiblessView {
    /// - Properties
    var viewNotReady = true
    let disposeBag = DisposeBag()
    let viewModel: SignInViewModel

    public init(frame: CGRect = .zero, viewModel: SignInViewModel) {
      self.viewModel = viewModel
      super.init(frame: frame)
      
      self.backgroundColor = .systemBackground
   
    }
    
    lazy var logoImg: UIImageView = {
        self.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        let top = $0.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 45)
        let centerX = $0.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        let width = $0.widthAnchor.constraint(equalToConstant: 120)
        let height = $0.heightAnchor.constraint(equalToConstant: 120)
        NSLayoutConstraint.activate([top, centerX, width, height])
        $0.image = #imageLiteral(resourceName: "mail")
        return $0
    }(UIImageView())
   
}
