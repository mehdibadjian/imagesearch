//
//  LandingViewModel.swift
//  ImageSearch
//
//  Created by Mehdi on 23/10/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import UIKit
class LandingViewModel: BaseViewModel {
    fileprivate var dataModel = [LandingModel]()
    func onQuery(_ query: Query, urlSession: URLSession? = nil) {
        let queryService: SearchQueryService
        if let session = urlSession {
            queryService = SearchQueryService(session)
        } else {
            queryService = SearchQueryService()
        }
        queryService.enquiry(query, successBlock: { (response) in
            if let enquiry = response {
                if let jsonData = try? JSONSerialization.data( withJSONObject: enquiry, options: .prettyPrinted) {
                    if let responseModel = try? JSONDecoder().decode(QueryResponseModel.self, from: jsonData) {
                        self.dataModel = responseModel.value.map{ LandingModel(imageUrl: $0.image.thumbnail, title: $0.title, shortDesc: $0.keywords, date: $0.datePublished) }
                        self.delegate?.onSuccess()
                    } else {
                        self.delegate?.onFailure(error: nil)
                    }
                } else {
                    self.delegate?.onFailure(error: nil)
                }
            } else {
                self.delegate?.onFailure(error: nil)
            }
        }) { (error) in
            self.delegate?.onFailure(error: error)
        }
    }
    func getDataModel() -> [LandingModel] {
        return dataModel
    }
}
