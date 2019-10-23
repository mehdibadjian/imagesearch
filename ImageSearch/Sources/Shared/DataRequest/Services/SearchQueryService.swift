//
//  CityQueryService.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import UIKit
class SearchQueryService: RequestManager {
    init(_ urlSession: URLSession) {
        super.init()
        self.session = urlSession
    }
    func enquiry(_ query: Query, successBlock: @escaping ((Codable?) -> Void), failureBlock: @escaping ((NSError?) -> Void)) {
        self.get(urlString: ApiManager.urlString(query)) { (success, response, error) in
            if success {
                if let enquiry = response {
                    if let jsonData = try? JSONSerialization.data( withJSONObject: enquiry, options: .prettyPrinted) {
                        if let responseModel = try? JSONDecoder().decode(QueryResponseModel.self, from: jsonData) {
                            successBlock(responseModel)
                        } else {
                            failureBlock(error)
                        }
                    } else {
                        failureBlock(error)
                    }
                } else {
                    failureBlock(error)
                }
            } else {
                failureBlock(error)
            }
        }
    }
}
