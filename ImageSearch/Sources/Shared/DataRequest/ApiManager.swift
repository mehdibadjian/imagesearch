//
//  ApiManager.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
struct ApiManager {
    static func getPathFromURLString(_ urlString: String) -> String {
        let temp = urlString.replacingOccurrences(of: AppConstants.baseAPI, with: "")
        return temp
    }
}
enum API: String {
    case query = "&q="
    static func urlString(api: API, queryString: String? = nil, apiType: ApiType) -> String {
        let apiType: String  = String(format: "%@.ashx", apiType.rawValue)
        return String(format: "%@%@%@%@%@%@format=json", AppConstants.baseAPI, apiType, AppConstants.apiKey, api.rawValue, queryString?.urlCompatible ?? "", AppConstants.atSign)
    }
}

