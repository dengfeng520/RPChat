//
//  KeychainItemAccesssibility.swift
//  RPKeychain
//
//  Created by rp.wang on 2020/12/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import Foundation

protocol KeychainAttrReprentable {
  var keychainAttrValue: CFString { get }
}

public enum KeychainItemAccessibility {
  case afterFirstUnlock
  case afterFirstUnlockThisDeviceOnly
  case whenPasscodeSetThisDeviceOnly
  case whenUnlocked // The default case.
  case whenUnlockedThisDeviceOnly
  
  /// `always and alwaysThisDeviceOnly` are deprecated in iOS 12.0
  
  /// CFString -> KeychainItemAccessibility
  static func accessbilityForAttributeValue(_ keychainAttrValue: CFString) -> KeychainItemAccessibility? {
    for (key, value) in keychainAccessibilityLookup {
      if value == keychainAttrValue {
        return key
      }
    }
    
    return nil
  }
}

extension KeychainItemAccessibility: KeychainAttrReprentable {
  /// KeychainItemAccessibility -> CFString
  var keychainAttrValue: CFString {
    return keychainAccessibilityLookup[self]!
  }
}

private let keychainAccessibilityLookup: [KeychainItemAccessibility:CFString] = [
  .afterFirstUnlock              : kSecAttrAccessibleAfterFirstUnlock,
  .afterFirstUnlockThisDeviceOnly: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
  .whenPasscodeSetThisDeviceOnly : kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
  .whenUnlocked                  : kSecAttrAccessibleWhenUnlocked,
  .whenUnlockedThisDeviceOnly    : kSecAttrAccessibleWhenUnlockedThisDeviceOnly
]
