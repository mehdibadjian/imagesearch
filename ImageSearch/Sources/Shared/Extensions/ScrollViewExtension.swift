//
//  TableviewExtension.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import UIKit
extension UIScrollView {
    func showEmptyListMessage(_ message:String) {
        let messageLabel = UILabel(frame: self.bounds)
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.sizeToFit()
        if let `self` = self as? UITableView {
            self.backgroundView = messageLabel
            self.separatorStyle = .none
        }
    }
    func dismissEmptyListMessage() {
        if let `self` = self as? UITableView {
            DispatchQueue.main.async {
                self.backgroundView = UIView()
                self.separatorStyle = .singleLine
            }
        }
    }
}
