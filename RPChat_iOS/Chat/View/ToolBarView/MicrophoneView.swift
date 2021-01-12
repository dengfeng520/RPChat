//
//  MicrophoneView.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2021/1/12.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public class MicrophoneView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
//        let centerView = UIView()
//        addSubview(centerView)
//        centerView.translatesAutoresizingMaskIntoConstraints = false
//        centerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
//        centerView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
//        centerView.widthAnchor.constraint(equalToConstant: 135).isActive = true
//        centerView.heightAnchor.constraint(equalToConstant: 135).isActive = true
//        centerView.layer.cornerRadius = 67.5
//        centerView.backgroundColor = .subViewColor
        
        let microphoneBtn = UIButton()
        addSubview(microphoneBtn)
        microphoneBtn.translatesAutoresizingMaskIntoConstraints = false
        microphoneBtn.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        microphoneBtn.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        microphoneBtn.widthAnchor.constraint(equalToConstant: 135).isActive = true
        microphoneBtn.heightAnchor.constraint(equalToConstant: 135).isActive = true
        microphoneBtn.layer.cornerRadius = 67.5
        microphoneBtn.backgroundColor = .subViewColor
    }
}
