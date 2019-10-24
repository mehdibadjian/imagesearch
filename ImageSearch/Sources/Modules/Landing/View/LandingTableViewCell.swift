//
//  LandingTableViewCell.swift
//  ImageSearch
//
//  Created by Mehdi on 24/10/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import UIKit
class LandingTableViewCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
