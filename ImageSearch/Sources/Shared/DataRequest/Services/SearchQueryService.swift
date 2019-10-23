//
//  CityQueryService.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import UIKit
class SearchQueryService: RequestManager {
    func enquiry(queryString: String?, successBlock: @escaping (([AnyHashable: Any]?) -> Void), failureBlock: @escaping ((NSError?) -> Void)) {
        self.get(urlString: API.urlString(api: .query, apiType: .search)) { (success, response, error) in
            if success {
                successBlock(response)
            } else {
                failureBlock(error)
            }
        }
    }
}
