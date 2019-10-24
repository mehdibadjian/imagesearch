//
//  CityQueryService.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import UIKit
class SearchQueryService: RequestManager {
    init(_ urlSession: URLSession? = nil) {
        super.init()
        if let session = urlSession {
            self.session = session
        }
    }
    func enquiry(_ query: Query, successBlock: @escaping (([AnyHashable: Any]?) -> Void), failureBlock: @escaping ((NSError?) -> Void)) {
        self.get(urlString: ApiManager.urlString(query)) { (success, response, error) in
            if success {
                successBlock(response)
            } else {
                failureBlock(error)
            }
        }
    }
}
