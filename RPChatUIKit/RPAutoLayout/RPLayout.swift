//
//  RPLayout.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/10/21.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public struct RPLayout {
    public let view: UIView
    public let top: NSLayoutConstraint?
    public let left: NSLayoutConstraint?
    public let bottom: NSLayoutConstraint?
    public let right: NSLayoutConstraint?
    public let height: NSLayoutConstraint?
    public let width: NSLayoutConstraint?
    public let centerX: NSLayoutConstraint?
    public let centerY: NSLayoutConstraint?
    
    public init(view: UIView) {
        self.view = view
        top = nil
        left = nil
        bottom = nil
        right = nil
        height = nil
        width = nil
        centerX = nil
        centerY = nil
    }
    
    private init(view: UIView,
                 top: NSLayoutConstraint?,
                 left: NSLayoutConstraint?,
                 bottom: NSLayoutConstraint?,
                 right: NSLayoutConstraint?,
                 height: NSLayoutConstraint?,
                 width: NSLayoutConstraint?,
                 centerX: NSLayoutConstraint?,
                 centerY: NSLayoutConstraint?) {
        self.view = view
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
        self.height = height
        self.width = width
        self.centerX = centerX
        self.centerY = centerY
    }
    
    @discardableResult func update(edge: NSLayoutConstraint.Attribute, constraint: NSLayoutConstraint?) -> RPLayout {
        var top = self.top
        var left = self.left
        var bottom = self.bottom
        var right = self.right
        var height = self.height
        var width = self.width
        var centerX = self.centerX
        var centerY = self.centerY
        
        switch edge {
        case .top: top = constraint
        case .left: left = constraint
        case .bottom: bottom = constraint
        case .right: right = constraint
        case .height: height = constraint
        case .width: width = constraint
        case .centerX: centerX = constraint
        case .centerY: centerY = constraint
        default: return self
        }
        
        return RPLayout (
            view: self.view,
            top: top,
            left: left,
            bottom: bottom,
            right: right,
            height: height,
            width: width,
            centerX: centerX,
            centerY: centerY)
    }
    
    @discardableResult func insert(layout: RPLayout) -> RPLayout {
        return RPLayout(
            view: self.view,
            top: layout.top ?? top,
            left: layout.left ?? left,
            bottom: layout.bottom ?? bottom,
            right: layout.right ?? right,
            height: layout.height ?? height,
            width: layout.width ?? width,
            centerX: layout.centerX ?? centerX,
            centerY: layout.centerY ?? centerY)
    }
}



