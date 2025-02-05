//
//  UserDataView.swift
//  EDS_Store
//
//  Created by Илья Морозов on 05.02.2025.
//

import UIKit

enum UserDataError {
    case badConnection
    case emptyData
    case serverError
}

protocol UserDataViewProtocol: UIViewController {
    func saveData()
    func loadData()
    func success()
    func failure(error: UserDataError)
    var presenter: UserDataPresenterProtocol? { get set }
}


