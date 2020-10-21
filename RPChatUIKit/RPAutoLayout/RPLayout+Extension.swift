//
//  RPLayout+Extension.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/10/21.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

extension RPLayout {
    // MARK: RPLayout to superview edges
    @discardableResult
    public func topToSuperview(constant c: CGFloat = 0) -> RPLayout {
        guard let superview = view.superview else {
            return self
        }
        return rp_top(to: superview.top, constant: c)
    }
    
    @discardableResult
    public func leftToSuperview(constant c: CGFloat = 0) -> RPLayout {
        guard let superview = view.superview else {
            return self
        }
        return rp_left(to: superview.left, constant: c)
    }
    
    @discardableResult
    public func bottomToSuperview(constant c: CGFloat = 0) -> RPLayout {
        guard let superview = view.superview else {
            return self
        }
        return rp_bottom(to: superview.bottom, constant: c)
    }
    
    @discardableResult
    public func rightToSuperview(constant c: CGFloat = 0) -> RPLayout {
        guard let superview = view.superview else {
            return self
        }
        return rp_right(to: superview.right, constant: c)
    }
    
    @discardableResult
    public func edgesToSuperview(omitEdge e: NSLayoutConstraint.Attribute = .notAnAttribute, insets: UIEdgeInsets = UIEdgeInsets.zero) -> RPLayout {
        let superviewAnchors = topToSuperview(constant: insets.top)
            .leftToSuperview(constant: insets.left)
            .bottomToSuperview(constant: insets.bottom)
            .rightToSuperview(constant: insets.right)
            .update(edge: e, constraint: nil)
        return self.insert(layout: superviewAnchors)
    }
    
    // MARK: RPLayout to superview axises
    @discardableResult
    public func centerXToSuperview() -> RPLayout {
        guard let superview = view.superview else {
            return self
        }
        return rp_centerX(to: superview.centerX)
    }
    
    @discardableResult
    public func centerYToSuperview() -> RPLayout {
        guard let superview = view.superview else {
            return self
        }
        return rp_centerY(to: superview.centerY)
    }
    
    @discardableResult
    public func centerToSuperview() -> RPLayout {
        guard let superview = view.superview else {
            return self
        }
        return rp_centerX(to: superview.centerX)
            .rp_centerY(to: superview.centerY)
    }
}


extension RPLayout {
    @discardableResult
    public func rp_top(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .top, constraint: view.top.constraint(equalTo: anchor, constant: c))
    }
    
    @discardableResult
    public func rp_left(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .left, constraint: view.left.constraint(equalTo: anchor, constant: c))
    }
    
    @discardableResult
    public func rp_bottom(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .bottom, constraint: view.bottom.constraint(equalTo: anchor, constant: c))
    }
    
    @discardableResult
    public func rp_right(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .right, constraint: view.right.constraint(equalTo: anchor, constant: c))
    }
    
    // MARK: - greaterOrEqual
    @discardableResult
    public func rp_top(greaterOrEqual anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .top, constraint: view.top.constraint(greaterThanOrEqualTo: anchor, constant: c))
    }
    
    @discardableResult
    public func rp_left(greaterOrEqual anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .left, constraint: view.left.constraint(greaterThanOrEqualTo: anchor, constant: c))
    }
    
    @discardableResult
    public func rp_bottom(greaterOrEqual anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .bottom, constraint: view.bottom.constraint(greaterThanOrEqualTo: anchor, constant: c))
    }
    @discardableResult
    public func rp_right(greaterOrEqual anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .right, constraint: view.right.constraint(greaterThanOrEqualTo: anchor, constant: c))
    }
    
    // MARK: - lessOrEqual
    @discardableResult
    public func rp_top(lesserOrEqual anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .top, constraint: view.top.constraint(lessThanOrEqualTo: anchor, constant: c))
    }
    
    @discardableResult
    public func rp_left(lesserOrEqual anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .left, constraint: view.left.constraint(lessThanOrEqualTo: anchor, constant: c))
    }
    
    @discardableResult
    public func rp_bottom(lesserOrEqual anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .bottom, constraint: view.bottom.constraint(lessThanOrEqualTo: anchor, constant: c))
    }
    
    @discardableResult
    public func rp_right(lesserOrEqual anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .right, constraint: view.right.constraint(lessThanOrEqualTo: anchor, constant: c))
    }
    
    // MARK: Dimension anchors
    @discardableResult
    public func rp_height(constant c: CGFloat) -> RPLayout {
        return update(edge: .height, constraint: view.height.constraint(equalToConstant: c))
    }
    
    @discardableResult
    public func rp_height(to dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> RPLayout {
        return update(edge: .height, constraint: view.height.constraint(equalTo: dimension, multiplier: m))
    }
    
    @discardableResult
    public func rp_width(constant c: CGFloat) -> RPLayout {
        return update(edge: .width, constraint: view.width.constraint(equalToConstant: c))
    }
    
    @discardableResult
    public func rp_width(to dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> RPLayout {
        return update(edge: .width, constraint: view.width.constraint(equalTo: dimension, multiplier: m))
    }
    
    // MARK: Axis anchors
    @discardableResult
    public func rp_centerX(to axis: NSLayoutXAxisAnchor, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .centerX, constraint: view.centerX.constraint(equalTo: axis, constant: c))
    }
    
    @discardableResult
    public func rp_centerY(to axis: NSLayoutYAxisAnchor, constant c: CGFloat = 0) -> RPLayout {
        return update(edge: .centerY, constraint: view.centerY.constraint(equalTo: axis, constant: c))
    }
    
    // MARK: config
    @discardableResult
    public func rp_activate() -> RPLayout {
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [top, left, bottom, right, height, width, centerX, centerY].compactMap({ $0 })
        NSLayoutConstraint.activate(constraints)
        return self
    }
}
