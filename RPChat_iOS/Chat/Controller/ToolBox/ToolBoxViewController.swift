//
//  ToolBarViewController.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/12.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPChatDataKit
import RPChatUIKit

class ToolBoxViewController: UIViewController {

    let disposeBag: DisposeBag = DisposeBag()
    var viewModel: ChatViewModel = ChatViewModel()
    var emoJiNameListSub = PublishSubject<[EmojiModel]>()
    var emoticonsListSub = PublishSubject<[[String]]>()
    
    /// 点击发送消息
    let tapSendMessageSubject = PublishSubject<String>()
    /// 弹出键盘 或 emoji
    let showKeyboardOrEmojiSubject = PublishSubject<CGFloat>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBinding()
    }
    
    func setupBinding() {
        // 选择emoji
        emojiView.selectEmojiSub.subscribe(onNext: { emojiname in
            
        }).disposed(by: disposeBag)
        
        monitorKeyBoard()
    }
    
    lazy var toolView: ToolView = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        $0.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 55).isActive = true
        $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        $0.backgroundColor = .darkModeViewColor
        return $0
    }(ToolView(frame: .zero))
    
    lazy var emojiView: EmojiView = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: toolView.bottomAnchor, constant: 0).isActive = true
        $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        $0.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        $0.isHidden = true
        return $0
    }(EmojiView(frame: .zero))
    
    lazy var menuView: MenuView = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        $0.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        $0.topAnchor.constraint(equalTo: toolView.bottomAnchor, constant: 0).isActive = true
        $0.isHidden = true
        return $0
    }(MenuView(frame: .zero))
    
    lazy var microphoneView: MicrophoneView = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        $0.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        $0.topAnchor.constraint(equalTo: toolView.bottomAnchor, constant: 0).isActive = true
        $0.isHidden = true
        return $0
    }(MicrophoneView(frame: .zero))
}
