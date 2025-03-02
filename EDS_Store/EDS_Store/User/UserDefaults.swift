//
//  UserDefaults.swift
//  EDS_Store
//
//  Created by Илья Морозов on 16.02.2025.
//

import Foundation

class UserDefaultsData {
    
    private let userDefaults = UserDefaults.standard
    private let key = "user"
    
    static let shared = UserDefaultsData()
    
    private init() {}
    
    func setUser(_ person: Person) {
        if let encode = try? JSONEncoder().encode(person) {
            userDefaults.set(encode, forKey: key)
            print("i Save user ")
        }
    }
    
    func clearUser() {
        userDefaults.removeObject(forKey: key)
    }
    
    func getUser() -> Person? {
        if let savedUser = userDefaults.data(forKey: key) {
            if let encodePerson = try? JSONDecoder().decode(Person.self, from: savedUser) {
                print("i get user ")
                return encodePerson
            }
        }
        return nil
    }
}
