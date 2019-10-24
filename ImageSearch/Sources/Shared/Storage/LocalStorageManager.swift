//
//  LocalStorageManager.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import Foundation
class LocalStorageManager {
    var defaults: UserDefaults = UserDefaults.standard
    static let sharedInstance = LocalStorageManager()
    func getStoredValuesFor(key: String) -> Any? {
        if let searchHistory = defaults.value(forKey: AppConstants.searchHistoryKey) as? [AnyHashable: Any], searchHistory.keys.contains(key) {
            return searchHistory[key]
        } else {
            return nil
        }
    }
    //TODO: Unit test
    func getAllStoredData() -> NSDictionary? {
        if let searchHistory = defaults.value(forKey: AppConstants.searchHistoryKey) as? NSDictionary {
            return searchHistory
        } else {
            return nil
        }
    }
    //TODO: Unit test
    func storeValueFor(key: String, value: Data) {
        if var searchHistory = defaults.value(forKey: AppConstants.searchHistoryKey) as? [AnyHashable: Any], searchHistory.keys.contains(key) {
            searchHistory.updateValue(value, forKey: key)
            defaults.set(searchHistory, forKey: AppConstants.searchHistoryKey)
            defaults.synchronize()
        } else if var searchHistory = defaults.value(forKey: AppConstants.searchHistoryKey) as? [AnyHashable: Any] {
            searchHistory[key] = value
            defaults.set(searchHistory, forKey: AppConstants.searchHistoryKey)
            defaults.synchronize()
        } else {
            let historyObj: [AnyHashable: Any] = [key: value]
            defaults.set(historyObj, forKey: AppConstants.searchHistoryKey)
            defaults.synchronize()
        }
    }
    func resetStorage(key: String) {
        defaults.set(nil, forKey: AppConstants.searchHistoryKey)
        defaults.synchronize()
    }
}
