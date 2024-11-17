//
//  RegistrationViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 16.11.2024.
//
import UIKit

class RegistrationViewController: UIViewController {
    
    let buttonsRadius: CGFloat = 13
    
    private lazy var welcomLabel:  UILabel = {
        let label = UILabel()
        label.text = "Зарегистрируйтесь чтобы офрмить заказ"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo7")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = buttonsRadius
        textField.borderStyle = .none
        textField.placeholder = "Введите Имя"
        textField.layer.borderWidth = 1.5
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = buttonsRadius
        textField.borderStyle = .none
        textField.placeholder = "Введите Почту"
        textField.layer.borderWidth = 1.5
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = buttonsRadius
        textField.borderStyle = .none
        textField.placeholder = "Введите Пароль"
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var confinrmЗasswordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = buttonsRadius
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = "Подтвердите Пароль"
        textField.layer.borderWidth = 1.5
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameTextField, emailTextField, passwordTextField, confinrmЗasswordTextField])
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "Регистрация"
        setupAll()
    }
    
    func setupAll(){
        setupLabel(welcomLabel)
        setupStackView(stackView)
        setupLogo()
    }
    
    func setupLabel(_ label: UILabel) {
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8).isActive = true
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupStackView(_ stackView: UIStackView) {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomLabel.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            stackView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.425)])
    }
    
    func setupLogo() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 150)])
    }
}
