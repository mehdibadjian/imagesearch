//
//  ApiManager.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
struct Query {
    var query: String
    var pageNumber: String
    var pageSize: String
    init(query: String, pageNumber: String, pageSize: String) {
        self.query = query
        self.pageNumber = pageNumber
        self.pageSize = pageSize
    }
}
struct ApiManager {
    fileprivate static func getEndPoints(_ query: Query) -> String {
        return AppConstants.query + query.query + AppConstants.atSign + AppConstants.pageNumber + query.pageNumber + AppConstants.atSign + AppConstants.pageSize + query.pageSize
    }
    static func urlString(_ query: Query) -> String {
        return AppConstants.baseAPI + getEndPoints(query)
    }
}

