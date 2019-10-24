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
    override func setUp() {
    }
    override func tearDown() {
    }
    func testLocalFileManager() {
        let key = "Name"
        let value = "Mehdi"
        let value2 = "Badjian"
        LocalStorageManager.sharedInstance.resetStorage(key: key)
        var storedValue = LocalStorageManager.sharedInstance.getStoredValuesFor(key: key) as? [String]
        XCTAssertEqual(storedValue, nil)
        LocalStorageManager.sharedInstance.storeValueFor(key: key, value: value)
        storedValue = LocalStorageManager.sharedInstance.getStoredValuesFor(key: key) as? [String]
        XCTAssertEqual(storedValue, [value])
        LocalStorageManager.sharedInstance.storeValueFor(key: key, value: value2)
        storedValue = LocalStorageManager.sharedInstance.getStoredValuesFor(key: key) as? [String]
        XCTAssertEqual(storedValue, [value2, value])
    }
}
