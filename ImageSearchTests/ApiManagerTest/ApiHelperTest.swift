//
//  ApiManagerTests.swift
//  WeatherAppTests
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import XCTest
@testable import ImageSearch
class ApiHelperTest: XCTestCase {
    func testApiHelper() {
        let query = Query(query: "test", pageNumber: AppConstants.defaultPageNumber, pageSize: AppConstants.defaultPageSize)
        XCTAssertNotNil(ApiManager.urlString(query))
        XCTAssertEqual(ApiManager.urlString(query), "https://contextualwebsearch-websearch-v1.p.rapidapi.com/api/Search/WebSearchAPI?q=test&pageNumber=1&pageSize=10")
    }
}
