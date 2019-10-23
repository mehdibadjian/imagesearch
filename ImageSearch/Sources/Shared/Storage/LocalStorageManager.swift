//
//  LocalStorageManager.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import Foundation
class LocalStorageManager {
    var defaults: UserDefaults? = UserDefaults.standard
    static let sharedInstance = LocalStorageManager()
    func getStoredValuesFor(key: String) -> Any? {
        return defaults?.value(forKey: key)
    }
    func storeValueFor(key: String, value: String) {
        if let storedValue = defaults?.value(forKey: key) {
            switch storedValue {
            case is [String]:
                if var valueArray = storedValue as? [String] {
                    if let index = valueArray.firstIndex(of: value) {
                        valueArray.remove(at: index)
                    }
                    valueArray.insert(value, at: 0)
                    defaults?.set(valueArray, forKey: key)
                }
            default: break
            }
        } else {
            let valueArray = [value]
            defaults?.set(valueArray, forKey: key)
        }
    }
    func resetStorage(key: String) {
        defaults?.set(nil, forKey: key)
    }
}
