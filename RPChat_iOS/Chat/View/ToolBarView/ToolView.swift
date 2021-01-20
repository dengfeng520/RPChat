//
//  ToolView.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/6.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPChatUIKit

public class ToolView: UIView {
    
    let disposeBag: DisposeBag = DisposeBag()
    
    public let microphoneBtn: UIButton =  UIButton()
    public let inputChatView: UITextView = UITextView()
    public let emoticonsBtn: UIButton = UIButton()
    public let moreBtn: UIButton = UIButton()
    
    public let tapToolBtnSubject: PublishSubject<KeyboardVisible> = PublishSubject()
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configToolViewUI()
        bindTap()
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
        microphoneBtn.imageView?.contentMode = .scaleAspectFill
        microphoneBtn.setImage(UIImage(named: "recording"), for: .normal)
        microphoneBtn.setImage(UIImage(named: "select_recording"), for: .highlighted)
        microphoneBtn.setImage(UIImage(named: "select_recording"), for: .selected)
        
        self.addSubview(moreBtn)
        moreBtn.translatesAutoresizingMaskIntoConstraints = false
        moreBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13.5).isActive = true
        moreBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        moreBtn.widthAnchor.constraint(equalToConstant: 28).isActive = true
        moreBtn.heightAnchor.constraint(equalToConstant: 28).isActive = true
        moreBtn.imageView?.contentMode = .scaleAspectFill
        moreBtn.setImage(UIImage(named: "tool_add"), for: .normal)
        moreBtn.setImage(UIImage(named: "select_tool_add"), for: .highlighted)
        moreBtn.setImage(UIImage(named: "select_tool_add"), for: .selected)
        
        self.addSubview(emoticonsBtn)
        emoticonsBtn.translatesAutoresizingMaskIntoConstraints = false
        emoticonsBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13.5).isActive = true
        emoticonsBtn.rightAnchor.constraint(equalTo: moreBtn.leftAnchor, constant: -5).isActive = true
        emoticonsBtn.widthAnchor.constraint(equalToConstant: 28).isActive = true
        emoticonsBtn.heightAnchor.constraint(equalToConstant: 28).isActive = true
        emoticonsBtn.imageView?.contentMode = .scaleAspectFill
        emoticonsBtn.setImage(UIImage(named: "emoticons"), for: .normal)
        emoticonsBtn.setImage(UIImage(named: "select_emoticons"), for: .highlighted)
        emoticonsBtn.setImage(UIImage(named: "select_emoticons"), for: .selected)
        
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
        inputChatView.returnKeyType = .send
    }
}

extension ToolView {
    private func bindTap() {
        /// 麦克风
        microphoneBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            self.microphoneBtn.isSelected = true
            self.moreBtn.isSelected = false
            self.emoticonsBtn.isSelected = false
            self.tapToolBtnSubject.onNext(.microphone)
        }).disposed(by: disposeBag)
        /// 更多
        moreBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            self.microphoneBtn.isSelected = false
            self.moreBtn.isSelected = true
            self.emoticonsBtn.isSelected = false
            self.tapToolBtnSubject.onNext(.menu)
        }).disposed(by: disposeBag)
        /// emoji
        emoticonsBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            self.microphoneBtn.isSelected = false
            self.moreBtn.isSelected = false
            self.emoticonsBtn.isSelected = true
            self.tapToolBtnSubject.onNext(.emoji)
        }).disposed(by: disposeBag)
    }
    
    func resetSelectStatus() {
        self.microphoneBtn.isSelected = false
        self.moreBtn.isSelected = false
        self.emoticonsBtn.isSelected = false
    }
}
