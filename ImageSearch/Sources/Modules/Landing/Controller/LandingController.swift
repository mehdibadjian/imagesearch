//
//  LandingController.swift
//  ImageSearch
//
//  Created by Mehdi on 24/10/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import UIKit
class LandingController: BaseViewController {
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
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: "LandingTableViewCell", bundle: bundle)
            tableView.register(nib, forCellReuseIdentifier: "LandingTableViewCell")
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 100
        }
    }
    var resultSearchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        //To-Do:- use localization
        self.title = "Landing"
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel = LandingViewModel(self, scrollView: tableView)
        viewModel.loadLocalData()
    }
}
