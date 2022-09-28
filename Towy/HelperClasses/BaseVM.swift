//
//  BaseVM.swift
//  Towy
//
//  Created by Usman on 27/06/2022.
//

import Foundation

import UIKit

enum AlertType {
    case normal
    case warning
    case error
    case success
    case custom
}
enum Valid {
    case success
    case failure(String)
}
class BaseVM: NSObject {

    var isLoading: Bool = false{
        didSet {
            self.updateLoadingStatus?()
        }
    }
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?(.success)
        }
    }
    var errorMessage: String? {
        didSet {
            self.showAlertClosure?(.error)
        }
    }
    var isSuccess: Bool? {
        didSet {
            if isSuccess ?? false {
                self.redirectControllerClosure?()
            }
        }
    }
    var isFailed: Bool? {
        didSet {
            self.showAlertClosure?(.error)
        }
    }
    var showAlertClosure: ((_ type: AlertType) -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var reloadListViewClosure: (() -> Void)?
    var redirectControllerClosure: (() -> Void)?
}
