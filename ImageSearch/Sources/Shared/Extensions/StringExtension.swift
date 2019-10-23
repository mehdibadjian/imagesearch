//
//  StringExtension.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import Foundation
extension String {
    var urlCompatible: String {
        return self.lowercased().replacingOccurrences(of: " ", with: "+")
    }
}
