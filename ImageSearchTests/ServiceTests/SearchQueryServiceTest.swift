//
//  SearchQueryServiceTest.swift
//  ImageSearchTests
//
//  Created by Mehdi on 23/10/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import XCTest
@testable import ImageSearch
class SearchQueryServiceTest: XCTestCase {
    var queryService: SearchQueryService!
    var mockURLSession: MockURLSession!
    override func setUp() {
        let bundle = Bundle.init(for: SearchQueryServiceTest.self)
        if let path = bundle.path(forResource: "query", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let response = HTTPURLResponse(url: URL(string: "http://test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
                mockURLSession = MockURLSession(data: data, response: response, error: nil)
            } catch {
                mockURLSession = MockURLSession()
            }
        } else {
            mockURLSession = MockURLSession()
        }
        queryService = SearchQueryService(mockURLSession)
    }
    override func tearDown() {
        queryService = nil
        mockURLSession = nil
    }
    fileprivate func fulfillBlock(_ promise: inout XCTestExpectation) {
        XCTAssertNotNil(self.mockURLSession.request)
        XCTAssertEqual(self.mockURLSession.request?.url?.absoluteString, "https://contextualwebsearch-websearch-v1.p.rapidapi.com/api/Search/WebSearchAPI?q=Test&pageNumber=1&pageSize=10")
        promise.fulfill()
    }
    func testEnquiryService() {
        var promise = expectation(description: "Request is not nill and has expected URL")
        queryService.enquiry( Query(query: "Test", pageNumber: "1", pageSize: "10"), successBlock: { (response) in
            XCTAssertNotNil(response)
            self.fulfillBlock(&promise)
        }, failureBlock: { (_) in
            self.fulfillBlock(&promise)
        })
        wait(for: [promise], timeout: 2)
    }
}
