//
//  BaseViewController.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import UIKit
class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBigNavigation()
        hideKeyboardWhenTappedAround()
    }
    func setupBigNavigation() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    var mainViewSafeAreaWidth: CGFloat {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            if #available(iOS 11.0, *) {
                if let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.left,
                    topPadding > 0 {
                    return self.view.frame.width - (topPadding * 2)
                }
            }
        }
        return self.view.frame.width
    }
}
