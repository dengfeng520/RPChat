//
//  DefaultModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2021/2/2.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

/// 为model数据设置默认值
@propertyWrapper 
struct Default<T: DefaultValue> {
   public var wrappedValue: T.Value
}

extension Default: Decodable {
   public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }
}

extension KeyedDecodingContainer {
    func decode<T>(
        _ type: Default<T>.Type,
        forKey key: Key
    ) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
    }
}

public protocol DefaultValue {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}
extension Bool {
    enum False: DefaultValue {
        static let defaultValue = false
    }
    enum True: DefaultValue {
        static let defaultValue = true
    }
}

extension MessageType: DefaultValue {
    public static let defaultValue = MessageType.text
}
