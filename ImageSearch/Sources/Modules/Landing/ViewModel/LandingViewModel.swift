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
    fileprivate var searchHistoryModel = [String]()
    fileprivate var scrollView: UIScrollView!
    let emptyStateString = "No results :-(\n\nPlease try searching for a valid location"
    init(_ delegate: ViewModelDelegate? = nil, scrollView: UIScrollView) {
        super.init(delegate)
        self.scrollView = scrollView
    }
    func loadLocalData() {
        if let historyArray = LocalStorageManager.sharedInstance.getStoredValuesFor(key: AppConstants.searchHistoryKey) as? [String] {
            searchHistoryModel = historyArray
        }
    }
    func onQuery(_ queryString: String, urlSession: URLSession? = nil) {
        let query = Query(query: queryString, pageNumber: AppConstants.defaultPageNumber, pageSize: AppConstants.defaultPageSize)
        let queryService: SearchQueryService
        if let session = urlSession {
            queryService = SearchQueryService(session)
        } else {
            queryService = SearchQueryService()
        }
        delegate?.loading(true)
        queryService.enquiry(query, successBlock: { (response) in
            if let enquiry = response {
                if let jsonData = try? JSONSerialization.data( withJSONObject: enquiry, options: .prettyPrinted) {
                    if let responseModel = try? JSONDecoder().decode(QueryResponseModel.self, from: jsonData) {
                        self.dataModel = responseModel.value.map{ LandingModel(imageUrl: $0.image.thumbnail, title: $0.title, shortDesc: $0.keywords, date: $0.datePublished) }
                        self.delegate?.loading(false)
                        self.delegate?.onSuccess()
                    } else {
                        self.delegate?.loading(false)
                        self.delegate?.onFailure(error: nil)
                    }
                } else {
                    self.delegate?.loading(false)
                    self.delegate?.onFailure(error: nil)
                }
            } else {
                self.delegate?.loading(false)
                self.delegate?.onFailure(error: nil)
            }
        }) { (error) in
            self.delegate?.loading(false)
            self.delegate?.onFailure(error: error)
        }
    }
    func getDataModel() -> [LandingModel] {
        return dataModel
    }
    func numberOfRows() -> Int {
        return dataModel.count
    }
    func cellForRow(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableView = scrollView as? UITableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            let model = dataModel[indexPath.row]
            cell.imageView?.load(urlString: model.imageUrl)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
