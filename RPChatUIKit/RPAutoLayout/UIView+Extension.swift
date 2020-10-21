//
//  UIView+Extension.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/10/21.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public extension UIView {
    func rpLayout() -> RPLayout { return RPLayout(view: self) }
    
    var top: NSLayoutAnchor<NSLayoutYAxisAnchor> { return topAnchor }
    var left: NSLayoutAnchor<NSLayoutXAxisAnchor> { return leftAnchor }
    var bottom: NSLayoutAnchor<NSLayoutYAxisAnchor> { return bottomAnchor }
    var right: NSLayoutAnchor<NSLayoutXAxisAnchor> { return rightAnchor }
    var height: NSLayoutDimension { return heightAnchor }
    var width: NSLayoutDimension { return widthAnchor }
    var centerX: NSLayoutXAxisAnchor { return centerXAnchor }
    var centerY: NSLayoutYAxisAnchor { return centerYAnchor }
    
    /// addSubview
    @discardableResult func rp_add(_ subView: UIView?) -> UIView {
        guard let `subView` = subView else {
            return self
        }
        subView.addSubview(self)
        return self
    }
}
