//
//  LandingModel.swift
//  ImageSearch
//
//  Created by Mehdi on 24/10/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//

import UIKit

struct LandingModel {
    var imageUrl: String
    var title: String
    var shortDesc: String
    var date: String
    init(imageUrl: String, title: String, shortDesc: String, date: String) {
        self.imageUrl = imageUrl
        self.title = title
        self.shortDesc = shortDesc
        self.date = date
    }
}
