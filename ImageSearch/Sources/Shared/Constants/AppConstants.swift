//
//  AppConstants.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import Foundation
class AppConstants {
    //To-Do:- get the API Key from remote
    static var apiKey: String = "0a79d28990msh4454299cdef3ad3p13d257jsn14d781e8dad1"
    static var baseAPI: String = "https://contextualwebsearch-websearch-v1.p.rapidapi.com/api/Search/WebSearchAPI?"
    static var host: String = "contextualwebsearch-websearch-v1.p.rapidapi.com"
    static var atSign: String = "&"
    static var pageNumber = "pageNumber="
    static var defaultPageNumber = "1"
    static var pageSize = "pageSize="
    static var defaultPageSize = "10"
    static var query = "q="
    static var loaderTag: Int = 1000
    static var maxHistoryCount: Int = 20
    static var searchHistoryKey: String = "searchHistoryKey"
}
