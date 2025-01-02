//
//  Corrector.swift
//  EDS_Store
//
//  Created by Илья Морозов on 02.12.2024.
//

import Foundation

class Checker {
    //regex for password
    let pasRegex1 = try! NSRegularExpression(pattern: "[0-9]+")
    let pasRegex2 = try! NSRegularExpression(pattern: "[a-z]+")
    let pasRegex3 = try! NSRegularExpression(pattern: "[A-Z]+")
    let pasRegex4 = try! NSRegularExpression(pattern: "[!+?.,#-]+")
    
    //regex for login
    let loginRegex = try! NSRegularExpression(pattern: "[a-zA-z0-9]+@[a-zA-Z0-9]+\\.[a-zA-Z0-9]+")
    
    //regex for usernanme
    let userNameRegex = try! NSRegularExpression(pattern: "[a-zA-z0-9]{4,16}")
    
    //regex for phone
    let phoneRegex = try! NSRegularExpression(pattern: "[+]7[0-9]{10}")
    
    func checkPassword(_ text: String?) -> Bool {
        guard let text = text else { return false }
        let passordRegexes = [pasRegex1, pasRegex2, pasRegex3, pasRegex4]
        let range = NSRange(location: 0, length: text.utf16.count)
        for regex in passordRegexes {
            if !(regex.firstMatch(in: text, options: [], range: range) != nil) {
                return false
            }
        }
        return true
    }
    
    func checkEqualPasswords(_ password: String?, _ confirmPassword: String?) -> Bool {
        guard let password = password, let confirmPassword = confirmPassword else { return false }
        return password == confirmPassword
    }
    
    func checkEmail(_ text: String?) -> Bool {
        guard let text = text else { return false }
        let range = NSRange(location: 0, length: text.utf16.count)
        if !(loginRegex.firstMatch(in: text, range: range) != nil) {
            return false
        }
        return true
    }
    
    func checkUserName(_ text: String?) -> Bool {
        guard let text = text else { return false }
        let range = NSRange(location: 0, length: text.utf16.count)
        if !(userNameRegex.firstMatch(in: text, range: range) != nil) {
            return false
        }
        return true
    }
    
    func checkPhone(_ text: String?) -> Bool {
        guard let text = text else { return false }
        let range = NSRange(location: 0, length: text.utf16.count)
        if !(phoneRegex.firstMatch(in: text, range: range) != nil) {
            return false
        }
        return true
    }
    
}

let checkAll = Checker()
