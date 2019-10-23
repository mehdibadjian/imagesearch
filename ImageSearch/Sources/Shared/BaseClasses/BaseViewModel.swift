//
//  BaseViewModel.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import Foundation
protocol ViewModelDelegate: class {
    func onSuccess()
    func onFailure(error: Error?)
    func loading(_ loading: Bool)
}
extension ViewModelDelegate {
    func onSuccess() { }
    func onFailure(error: Error?) { }
    func loading(_ loading: Bool) { }
}
class BaseViewModel: NSObject {
    //MARK: Properties
    weak var delegate: ViewModelDelegate?
    init(_ delegate: ViewModelDelegate? = nil) {
        super.init()
        self.delegate = delegate
    }
}
