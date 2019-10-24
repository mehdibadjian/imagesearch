//
//  QueryResponseModel.swift
//  ImageSearch
//
//  Created by Mehdi on 23/10/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
struct QueryResponseModel: Codable {
    let type, didUMean: String?
    let totalCount: Int?
    let relatedSearch: [String]?
    let value: [Value]
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case didUMean, totalCount, relatedSearch, value
    }
}
// MARK: - Value
struct Value: Codable {
    let title: String?
    let url: String?
    let valueDescription, keywords: String?
    let language: String?
    let isSafe: Bool?
    let datePublished: String?
    let provider: Provider?
    let image: Image?
    enum CodingKeys: String, CodingKey {
        case valueDescription = "description"
        case title, url, keywords, language, isSafe, datePublished, provider, image
    }
}
// MARK: - Image
struct Image: Codable {
    let url: String?
    let height, width: Int?
    let thumbnail: String?
    let thumbnailHeight, thumbnailWidth: Int?
    let base64Encoding: String?
}
// MARK: - Provider
struct Provider: Codable {
    let name: String?
}
