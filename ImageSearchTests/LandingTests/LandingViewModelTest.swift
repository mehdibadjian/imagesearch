//
//  LandingViewModelTest.swift
//  ImageSearchTests
//
//  Created by Mehdi on 24/10/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import XCTest
@testable import ImageSearch
class LandingViewModelTest: XCTestCase {
    var viewModel: LandingViewModel!
    var mockURLSession: MockURLSession!
    var queryPromise: XCTestExpectation!
    override func setUp() {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        viewModel = LandingViewModel(self, scrollView: tableView)
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
    }
    override func tearDown() {
        viewModel = nil
        mockURLSession = nil
        queryPromise = nil
    }
    func testOnQuery() {
        queryPromise = expectation(description: "viewmodel has a datamodel with objects")
        viewModel.onQuery("Test", urlSession: mockURLSession)
        wait(for: [queryPromise], timeout: 1)
    }
}
extension LandingViewModelTest: ViewModelDelegate {
    func onSuccess() {
        XCTAssertNotNil(viewModel.getDataModel())
        XCTAssertEqual(viewModel.getDataModel().count, 10)
        XCTAssertEqual(viewModel.numberOfRows(), 10)
        XCTAssertNotNil(viewModel.cellForRow(cellForRowAt: IndexPath(row: 0, section: 0)))
        queryPromise.fulfill()
    }
    func onFailure(error: Error?) {
        XCTAssertNotNil(viewModel.getDataModel())
        XCTAssertEqual(viewModel.getDataModel().count, 0)
        queryPromise.fulfill()
    }
}
