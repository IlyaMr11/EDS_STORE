//
//  Alerts.swift
//  EDS_Store
//
//  Created by Илья Морозов on 02.12.2024.
//

import UIKit

class Alerts {
    
    static let shared = Alerts()
    
    lazy var serverErrorAlert: UIAlertController = {
        let alert = UIAlertController(title: "Ошибка сервера", message: "Проверьте подключение к интернету", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        return alert
    }()
    
    lazy var userNoFoundAlert: UIAlertController = {
        let alert = UIAlertController(title: "Неверный логин", message: "Нет пользователя с таким логином, попробуйте другой", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        return alert
    }()
    
    lazy var wrongPasswordAlert: UIAlertController = {
        let alert = UIAlertController(title: "Неверный пароль", message: "Попробуйте другой пароль", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        return alert
    }()
    
    lazy var phoneAlert: UIAlertController = {
        let alert = UIAlertController(title: "Некорректный телефон", message: "Введите телефон еше раз", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
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
    
    lazy var noUserAlert: UIAlertController = {
        let alert = UIAlertController(title: "Пользователь не авторизован", message: "Войдите в акаунт для того чтобы добавить товар", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }()
    
    lazy var emptyBagAlert: UIAlertController = {
        let alert = UIAlertController(title: "Корзина пуста", message: "Добавьте товары в корзину", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }()
    
    lazy var loginNoFreeAlert: UIAlertController = {
        let alert = UIAlertController(title: "Логин уже занят", message: "Введите другой логин", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }()
    
    lazy var dataErrorAlert: UIAlertController = {
        let alert = UIAlertController(title: "Некоректные данные", message: "Введите корректные данные", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }()
    
    lazy var badConnectionAlert: UIAlertController = {
        let alert = UIAlertController(title: "Плохое соединение", message: "Установите стабильное соединение с интернетом", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }()
    
    lazy var successSaveAlert: UIAlertController = {
        let alert = UIAlertController(title: "Сохранено", message: "Данные успешно сохранены", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }()
    
    lazy var noDataAlert: UIAlertController = {
        let alert = UIAlertController(title: "Нет данных", message: "Нет данных для отображения", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }()
}

let allAlerts = Alerts()


enum AlertType: String {
    case serverError = "server error"
    case userNotFound = "user not found"
    case wrongPassword = "wrong password"
    case phone = "phone"
    case email = "email"
    case userName
    case password
    case confirmPassword
    case noUser
    case emptyBasket
    case loginNoFree
    case dataError
    case badConnection
    case noData
    
    // Вычисляемое свойство для получения соответствующего алерта
    var alert: UIAlertController {
        switch self {
        case .serverError:
            return Alerts.shared.serverErrorAlert
        case .userNotFound:
            return Alerts.shared.userNoFoundAlert
        case .wrongPassword:
            return Alerts.shared.wrongPasswordAlert
        case .phone:
            return Alerts.shared.phoneAlert
        case .email:
            return Alerts.shared.emailAlert
        case .userName:
            return Alerts.shared.userNameAlert
        case .password:
            return Alerts.shared.passwordAlert
        case .confirmPassword:
            return Alerts.shared.confirmPasswordAlert
        case .noUser:
            return Alerts.shared.noUserAlert
        case .emptyBasket:
            return Alerts.shared.emptyBagAlert
        case .loginNoFree:
            return Alerts.shared.loginNoFreeAlert
        case .dataError:
            return Alerts.shared.dataErrorAlert
        case .badConnection:
            return Alerts.shared.badConnectionAlert
        case .noData:
            return Alerts.shared.noDataAlert
        }
    }
}


enum SuccessAlert {
    case successSave
    
    var alert: UIAlertController {
        switch self {
        case .successSave:
            Alerts.shared.successSaveAlert
        }
    }
}
