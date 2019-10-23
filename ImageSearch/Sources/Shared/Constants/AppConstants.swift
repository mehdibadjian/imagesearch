//
//  AppConstants.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import Foundation
enum ApiType: String {
    case weather
    case search
}
class AppConstants {
    //To-Do:- get the API Key from remote
    static var apiKey: String = "?key=f0b519ce0060402796a40014192509"
    static var baseAPI: String = "http://api.worldweatheronline.com/premium/v1/"
    static var atSign: String = "&"
    static var loaderTag: Int = 1000
    static var historyKey: String = "history"
    static var maxHistoryCount: Int = 10
}
