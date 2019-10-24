//
//  ViewExtension.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import UIKit
import Foundation
import SnapKit
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
            self.addSubview(container)
            container.snp.makeConstraints { (make) in
                make.size.equalToSuperview()
                make.center.equalToSuperview()
            }
            //loader view
            let loadingView = UIView()
            loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            container.addSubview(loadingView)
            loadingView.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize(width: 100, height: 100))
                make.center.equalToSuperview()
            }
            //activity indicator
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
            activityIndicator.center = self.center
            activityIndicator.startAnimating()
            loadingView.addSubview(activityIndicator)
            activityIndicator.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize(width: 150, height: 150))
                make.centerX.centerY.equalToSuperview()
            }
        }
    }
    func dismissLoader() {
        let loaderContainer = self.subviews.filter { $0.tag == AppConstants.loaderTag }
        loaderContainer.first?.isHidden = true
    }
}
