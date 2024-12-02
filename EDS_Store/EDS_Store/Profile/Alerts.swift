//
//  Alerts.swift
//  EDS_Store
//
//  Created by Илья Морозов on 02.12.2024.
//

import UIKit

class Alerts {
    
    lazy var phoneAlert: UIAlertController = {
        let alert = UIAlertController(title: "Некорректный телефон", message: "Введите телефон еше раз", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }()
    
    lazy var emailAlert: UIAlertController = {
        let alert = UIAlertController(title: "Неверный логин", message: "Попробуйте другой логин", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }()
    
    lazy var userNameAlert: UIAlertController = {
        let alert = UIAlertController(title: "Некорректное имя пользователя", message: "Придумайте новое имя", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }()
    
    lazy var passwordAlert: UIAlertController = {
        let alert = UIAlertController(title: "Некорректный пароль", message: "Введите новый пароль", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }()
    
    lazy var confirmPasswordAlert: UIAlertController = {
        let alert = UIAlertController(title: "Пароли не совпадают", message: "Повторите ввод пароля", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }()
}

let allAlerts = Alerts()
