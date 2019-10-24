//
//  LandingController.swift
//  ImageSearch
//
//  Created by Mehdi on 24/10/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import UIKit
class LandingController: UIViewController {
    var viewModel: LandingViewModel!
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        }
    }
    var resultSearchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        //To-Do:- use localization
        self.title = "Landing"
        //update view model from local storage
        viewModel.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel = LandingViewModel(self, scrollView: tableView)
        viewModel.loadLocalData()
        handleEmptyState()
    }
}
