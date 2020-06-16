//
//  NiblessView.swift
//  RPChatUIKit
//
//  Created by rp.wang on 2020/6/16.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

open class NiblessView: UIView {
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  @available(*, unavailable, message: "Loading this view from a nib is unsupported")
  public required init?(coder aDecoder: NSCoder) {
    fatalError("Loading this view from a nib is unsupported")
  }
}
