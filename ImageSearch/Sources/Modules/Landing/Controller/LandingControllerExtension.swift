//
//  LandingControllerExtension.swift
//  ImageSearch
//
//  Created by Mehdi on 24/10/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import UIKit
extension LandingController {
    func handleEmptyState() {
        if viewModel.getDataModel().isEmpty {
            tableView.showEmptyListMessage(viewModel.emptyStateString)
        } else {
            tableView.dismissEmptyListMessage()
        }
    }
}
extension LandingController: ViewModelDelegate {
    func loading(_ loading: Bool) {
        DispatchQueue.main.async {
            if loading {
                self.view.showLoader()
            } else {
                self.view.dismissLoader()
            }
        }
    }
    func onSuccess() {
        handleEmptyState()
        tableView.reloadData()
    }
    func onFailure(error: Error?) {
        handleEmptyState()
        tableView.reloadData()
    }
}
extension LandingController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRow(cellForRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension LandingController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.onQuery(searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.onQuery(searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
}