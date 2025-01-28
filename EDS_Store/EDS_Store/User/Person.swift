//
//  Person.swift
//  EDS_Store
//
//  Created by Илья Морозов on 11.01.2025.
//

import Foundation

struct Person {
    var login: String
    var password: String
}

class PersonData {
    static let shared = PersonData()
    
    
    private(set) var currentUser: Person?
    private init() {}
    
    func setUser(_ person: Person) {
        currentUser = person
    }
}
