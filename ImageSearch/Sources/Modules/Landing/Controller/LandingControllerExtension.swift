//
//  LandingControllerExtension.swift
//  ImageSearch
//
//  Created by Mehdi on 24/10/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import UIKit
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
        viewModel.handleEmptyState()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func onFailure(error: Error?) {
        viewModel.handleEmptyState()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        if let history = viewModel.objectAtIndex(indexPath) as? String {
            viewModel.onQuery(history)
        } else if let result = viewModel.objectAtIndex(indexPath) as? LandingModel {
            presentImage(imageUrl: result.imageUrl)
        }
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
extension LandingController {
    func presentImage(imageUrl: String?) {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "image-placeholder.jpg"))
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem:  self.view, attribute: .width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem:  self.view, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0),
            ])
        imageView.load(urlString: imageUrl, placeholder: #imageLiteral(resourceName: "image-placeholder.jpg"))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            imageView.removeFromSuperview()
        }
    }
}
