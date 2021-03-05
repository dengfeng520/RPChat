//
//  RPChatFPSLabel.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2021/2/4.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public class RPChatFPSLabel: UILabel {

    //CADisplayLink
    fileprivate var link: CADisplayLink?
    fileprivate var count: UInt = 0
    fileprivate var lastTime: TimeInterval = 0

    public override init(frame: CGRect) {
        super.init(frame: frame)
        /// 样式
        layer.cornerRadius = 5
        layer.masksToBounds = true
        backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        font = UIFont(name: "Menlo", size: 14)
        self.textAlignment = .center
        /// 防止循环引用
        link = CADisplayLink.init(target: self, selector: #selector(tick(_:)))
        /// main runloop 添加到
        link?.add(to: RunLoop.main, forMode: .common)
    }
    deinit {
        link?.invalidate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    /// 滴答滴答
    @objc fileprivate func tick(_ link: CADisplayLink) {
        if lastTime == 0 {
            lastTime = link.timestamp
            return
        }
        count = count + 1
        let delta = link.timestamp - lastTime
        if delta < 1 {
            return
        }
        lastTime = link.timestamp;
        let fps = Double(count) / delta
        count = 0
        let progress = fps / 60.0
        let color = UIColor.init(hue: CGFloat(0.27 * (progress - 0.2)), saturation: 1, brightness: 0.9, alpha: 1)
        self.textColor = color
        self.text = String.init(format: "%.0lf FPS", round(fps))
    }
}
