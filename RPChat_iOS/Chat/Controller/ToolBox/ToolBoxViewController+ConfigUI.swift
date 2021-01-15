//
//  ToolBoxViewController+ConfigUI.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/1/13.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RPChatDataKit

extension ToolBoxViewController {
    func resetStatus() {
        self.toolView.resetSelectStatus()
        
        microphoneView.isHidden = true
        emojiView.isHidden = true
        menuView.isHidden = true
    }
    func setupBinding() {
        // 选择emoji
        emojiView.selectEmojiSub.bind(to: selectEmojiName).disposed(by: disposeBag)
        // 切换emoji
        emojiView.tapBottomEmojiSubject?.bind(to: changeEmojiBottomTap).disposed(by: disposeBag)
        // 键盘监听
        monitorKeyBoard()
        // emoji 数据绑定
        if let emoticonsList = EmojiManager.fetchEmoticonsList {
            self.emoJiArray = emoticonsList
            self.emojiView.changeEmoji(self.emoJiArray.first)
        }
    }
}

extension ToolBoxViewController {
    // 选择emoji
    var selectEmojiName: Binder<String> {
        return Binder(self) { [weak self] (chatVC, emojiName) in
            guard let `self` = self else { return }
            
        }
    }
    // 切换emoji
    var changeEmojiBottomTap: Binder<Int> {
        return Binder(self) { [weak self] (chatVC, index) in
            guard let `self` = self else { return }
            self.emojiView.changeEmoji(self.emoJiArray[index])
        }
    }
}
