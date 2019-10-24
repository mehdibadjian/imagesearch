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
    fileprivate var loading: Bool = false {
        didSet {
            self.delegate?.loading(loading)
        }
    }
    fileprivate let emptyStateString = "No results :-(\n\nPlease try searching for a valid Query"
    init(_ delegate: ViewModelDelegate? = nil, scrollView: UIScrollView) {
        super.init(delegate)
        self.scrollView = scrollView
    }
    func loadLocalData() {
        if let historyArray = LocalStorageManager.sharedInstance.getStoredValuesFor(key: AppConstants.searchHistoryKey) as? [String] {
            searchHistoryModel = historyArray
        }
        handleEmptyState()
    }
    func onQuery(_ queryString: String, urlSession: URLSession? = nil) {
        guard !loading else {
            return
        }
        loading = true
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
                do {
                    let jsonData = try JSONSerialization.data( withJSONObject: enquiry, options: .prettyPrinted)
                    let responseModel = try JSONDecoder().decode(QueryResponseModel.self, from: jsonData)
                    self.dataModel = responseModel.value.map{ LandingModel(imageUrl: $0.image?.thumbnail, title: $0.title, shortDesc: $0.keywords, date: $0.datePublished) }
                    self.delegate?.onSuccess()
                    self.loading = false
                } catch {
                    self.delegate?.onFailure(error: nil)
                    self.loading = false
                }
            } else {
                self.delegate?.onFailure(error: nil)
                self.loading = false
            }
        }) { (error) in
            self.loading = false
            self.delegate?.onFailure(error: error)
        }
    }
    func getDataModel() -> [Any] {
        if !dataModel.isEmpty {
            return dataModel
        } else {
            return searchHistoryModel
        }
    }
    func numberOfRows() -> Int {
        return getDataModel().count
    }
    func cellForRow(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableView = scrollView as? UITableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LandingTableViewCell", for: indexPath) as! LandingTableViewCell
            let model = dataModel[indexPath.row]
            cell.iconView.load(urlString: model.imageUrl, placeholder: #imageLiteral(resourceName: "image-placeholder.jpg"))
            cell.titleLabel.text = model.title
            cell.subtitleLabel.text = model.shortDesc
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func handleEmptyState() {
        if getDataModel().isEmpty {
            scrollView.showEmptyListMessage(emptyStateString)
        } else {
            scrollView.dismissEmptyListMessage()
        }
    }
}
