//
//  ChatRightTriangleView.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/12/17.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public class ChatRightTriangleView: UIView {

    public override func draw(_ rect: CGRect) {
        // Drawing code
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(UIColor.hexStringToColor("0xF5BE62").cgColor)
        context.move(to: CGPoint(x: 0, y: self.bounds.size.height / 2 - 5))
        context.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.size.height / 2))
        context.addLine(to: CGPoint.init(x: 0, y: self.bounds.size.height / 2 + 5))
        context.closePath()
        context.drawPath(using: .fill)
    }

}
