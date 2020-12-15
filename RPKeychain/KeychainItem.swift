//
//  KeychainItem.swift
//  RPKeychain
//
//  Created by rp.wang on 2020/12/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation

@propertyWrapper
public struct KeychainStoreString {
    public let key: String
    
    public init(key: String) {
        self.key = key
    }
    
    public var wrappedValue: String? {
        get {
            RPKeychain.default.string(forKey: key)
        }
        
        set {
            guard let v = newValue else { return }
            
            RPKeychain.default.set(v, forKey: key)
        }
    }
    
    public var projectedValue: RPKeychain {
        get {
            return RPKeychain.default
        }
    }
}

@propertyWrapper
public struct KeychainStoreNumber<T> where T: Numeric, T: Codable {
    public let key: String
    
    public init(key: String) {
        self.key = key
    }
    
    public var wrappedValue: T? {
        get {
            RPKeychain.default.object(of: T.self, forKey: key)
        }
        
        set {
            guard let v = newValue else { return }
            
            RPKeychain.default.set(v, forKey: key)
        }
    }
    
    public var projectedValue: RPKeychain {
        get {
            return RPKeychain.default
        }
    }
}

@propertyWrapper
public struct KeychainStoreObject<T> where T: Codable {
    public let key: String
    
    public init(key: String) {
        self.key = key
    }
    
    public var wrappedValue: T? {
        get {
            RPKeychain.default.object(of: T.self, forKey: key)
        }
        
        set {
            guard let v = newValue else { return }
            
            RPKeychain.default.set(v, forKey: key)
        }
    }
    
    public var projectedValue: RPKeychain {
        get {
            return RPKeychain.default
        }
    }
}
