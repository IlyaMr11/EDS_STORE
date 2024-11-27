//
//  UpdateUserDataDelegate.swift
//  EDS_Store
//
//  Created by Илья Морозов on 27.11.2024.
//

import Foundation


protocol UpdateUserDataDelegate: AnyObject {
    func didUpdateName(_ data: String?)
}
