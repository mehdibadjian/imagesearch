//
//  StorageTest.swift
//  WeatherAppTests
//
//  Created by Mehdi on 26/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import XCTest
@testable import ImageSearch
class StorageTest: XCTestCase {
    override func tearDown() {
        LocalStorageManager.sharedInstance.resetStorage(key: AppConstants.searchHistoryKey)
    }
    func testLocalFileManager() {
        let key = "Name"
        guard let value = "Mehdi".data(using: .utf8), let value2 = "Badjian".data(using: .utf8) else {
            return
        }
        LocalStorageManager.sharedInstance.resetStorage(key: key)
        let storedValue = LocalStorageManager.sharedInstance.getStoredValuesFor(key: key)
        XCTAssertEqual(storedValue as? String, nil)
        LocalStorageManager.sharedInstance.storeValueFor(key: key, value: value)
        let storedValueData1 = LocalStorageManager.sharedInstance.getStoredValuesFor(key: key) as? Data
        let storedValuestring1 = String(data: storedValueData1!, encoding: String.Encoding.utf8)
        XCTAssertNotNil(storedValueData1)
        XCTAssertNotNil(storedValuestring1)
        XCTAssertEqual(storedValuestring1, "Mehdi")
        LocalStorageManager.sharedInstance.storeValueFor(key: key, value: value2)
        let storedValueData2 = LocalStorageManager.sharedInstance.getStoredValuesFor(key: key) as? Data
        let storedValuestring2 = String(data: storedValueData2!, encoding: String.Encoding.utf8)
        XCTAssertNotNil(storedValueData2)
        XCTAssertNotNil(storedValuestring2)
        XCTAssertEqual(storedValuestring2, "Badjian")
    }
}
