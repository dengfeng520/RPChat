//
//  ToolView.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/6.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RPChatUIKit

class ToolView: UIView {
    
    let disposeBag: DisposeBag = DisposeBag()
    
    let microphoneBtn: UIButton =  UIButton()
    let inputChatView: UITextView = UITextView()
    let emoticonsBtn: UIButton = UIButton()
    let moreBtn: UIButton = UIButton()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configToolViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configToolViewUI() {
        self.addSubview(microphoneBtn)
        microphoneBtn.translatesAutoresizingMaskIntoConstraints = false
        microphoneBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13.5).isActive = true
        microphoneBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        microphoneBtn.widthAnchor.constraint(equalToConstant: 28).isActive = true
        microphoneBtn.heightAnchor.constraint(equalToConstant: 28).isActive = true
        microphoneBtn.setImage(UIImage.init(named: "recording"), for: .normal)
        microphoneBtn.imageView?.contentMode = .scaleAspectFill
        
        self.addSubview(moreBtn)
        moreBtn.translatesAutoresizingMaskIntoConstraints = false
        moreBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13.5).isActive = true
        moreBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        moreBtn.widthAnchor.constraint(equalToConstant: 28).isActive = true
        moreBtn.heightAnchor.constraint(equalToConstant: 28).isActive = true
        moreBtn.setImage(UIImage(named: "tool_add"), for: .normal)
        moreBtn.imageView?.contentMode = .scaleAspectFill
        
        self.addSubview(emoticonsBtn)
        emoticonsBtn.translatesAutoresizingMaskIntoConstraints = false
        emoticonsBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13.5).isActive = true
        emoticonsBtn.rightAnchor.constraint(equalTo: moreBtn.leftAnchor, constant: -5).isActive = true
        emoticonsBtn.widthAnchor.constraint(equalToConstant: 28).isActive = true
        emoticonsBtn.heightAnchor.constraint(equalToConstant: 28).isActive = true
        emoticonsBtn.setImage(UIImage.init(named: "emoticons"), for: .normal)
        emoticonsBtn.imageView?.contentMode = .scaleAspectFill
        
        self.addSubview(inputChatView)
        inputChatView.translatesAutoresizingMaskIntoConstraints = false
        inputChatView.leftAnchor.constraint(equalTo: microphoneBtn.rightAnchor, constant: 8).isActive = true
        inputChatView.rightAnchor.constraint(equalTo: emoticonsBtn.leftAnchor, constant: -8).isActive = true
        inputChatView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        inputChatView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        inputChatView.heightAnchor.constraint(greaterThanOrEqualToConstant: 31).isActive = true
        inputChatView.backgroundColor = .subViewColor
        inputChatView.layer.cornerRadius = 4
        inputChatView.showsVerticalScrollIndicator = false
        inputChatView.font = UIFont.systemFont(ofSize: 17)
    }
}
