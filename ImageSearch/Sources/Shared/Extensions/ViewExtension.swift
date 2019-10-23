//
//  ViewExtension.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import UIKit
import Foundation
extension UIView {
    func showLoader() {
        let loaderContainer = self.subviews.filter({ $0.tag == AppConstants.loaderTag })
        if !loaderContainer.isEmpty {
            loaderContainer.first?.isHidden = false
        } else {
            //background view
            let container = UIView()
            container.frame = self.frame
            container.center = self.center
            container.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            container.tag = AppConstants.loaderTag
            //loader view
            let loadingView = UIView()
            loadingView.frame = CGRect.init(x: 0, y: 0, width: 80, height: 80)
            loadingView.center = self.center
            loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            //activity indicator
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
            activityIndicator.center = self.center
            activityIndicator.startAnimating()
            loadingView.addSubview(activityIndicator)
            container.addSubview(loadingView)
            self.addSubview(container)
        }
    }
    func dismissLoader() {
        let loaderContainer = self.subviews.filter { $0.tag == AppConstants.loaderTag }
        loaderContainer.first?.isHidden = true
    }
}
