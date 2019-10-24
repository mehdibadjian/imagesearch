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
    fileprivate var pageNumber: Int = AppConstants.defaultPageNumber.intValue
    fileprivate var queryString: String?
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
        if let historyArray = LocalStorageManager.sharedInstance.getAllStoredData() {
            if let keys = historyArray.allKeys as? [String] {
                searchHistoryModel = keys
            }
        }
        handleEmptyState()
    }
    func onQuery(_ queryString: String, urlSession: URLSession? = nil, nextPage: Bool = false) {
        guard !loading, !queryString.isEmpty else {
            return
        }
        self.queryString = queryString
        if let storedData = LocalStorageManager.sharedInstance.getStoredValuesFor(key: queryString) as? Data, !nextPage {
            do {
                let responseModel = try JSONDecoder().decode(QueryResponseModel.self, from: storedData)
                dataModel = responseModel.value.map { LandingModel(imageUrl: $0.image?.thumbnail,
                                                                   title: $0.title?.htmlToString,
                                                                   shortDesc: $0.provider?.name,
                                                                   date: $0.datePublished) }
                delegate?.onSuccess()
                loading = false
            } catch let error {
                delegate?.onFailure(error: error)
                loading = false
            }
            return
        }
        loading = true
        if nextPage {
            pageNumber += 1
        } else {
            pageNumber = AppConstants.defaultPageNumber.intValue
        }
        let query = Query(query: queryString,
                          pageNumber: pageNumber.stringValue,
                          pageSize: AppConstants.defaultPageSize)
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
                    LocalStorageManager.sharedInstance.storeValueFor(key: query.query, value: jsonData)
                    let responseModel = try JSONDecoder().decode(QueryResponseModel.self, from: jsonData)
                    if nextPage {
                        self.dataModel.append(contentsOf:responseModel.value.map {
                            LandingModel(imageUrl: $0.image?.thumbnail,
                                         title: $0.title?.htmlToString,
                                         shortDesc: $0.provider?.name,
                                         date: $0.datePublished) })
                    } else {
                        self.dataModel = responseModel.value.map {
                            LandingModel(imageUrl: $0.image?.thumbnail,
                                         title: $0.title?.htmlToString,
                                         shortDesc: $0.provider?.name,
                                         date: $0.datePublished) }
                    }
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
        }, failureBlock: { (error) in
            self.loading = false
            self.delegate?.onFailure(error: error)
        })
    }
    func nextPageQuery() {
        guard !getDataModel().isEmpty, let query = queryString, query.count != 0 else {
            return
        }
        onQuery(query, nextPage: true)
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
            if !dataModel.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LandingTableViewCell",
                                                         for: indexPath) as? LandingTableViewCell
                let model = dataModel[indexPath.row]
                cell?.iconView.load(urlString: model.imageUrl, placeholder: #imageLiteral(resourceName: "image-placeholder.jpg"))
                cell?.titleLabel.text = model.title
                cell?.subtitleLabel.text = model.shortDesc
                return cell!
            } else if !searchHistoryModel.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
                cell.textLabel?.text = searchHistoryModel[indexPath.row]
                return cell
            } else {
                return UITableViewCell()
            }
            
        } else {
            return UITableViewCell()
        }
    }
    func imageForRow(_ indexPath: IndexPath) -> String? {
        let model = dataModel[indexPath.row]
        return model.imageUrl
    }
    func objectAtIndex(_ indexPath: IndexPath) -> Any {
        if dataModel.indices.contains(indexPath.row) {
            return dataModel[indexPath.row]
        } else {
            return searchHistoryModel[indexPath.row]
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
