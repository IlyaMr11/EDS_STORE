//
//  RegistrationViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 16.11.2024.
//
import UIKit

class RegistrationViewController: UIViewController {
    
    //MARK: - CONSTANTS
    let buttonsRadius: CGFloat = 13
    
    let alertsArray = [allAlerts.userNameAlert, allAlerts.emailAlert, allAlerts.passwordAlert, allAlerts.confirmPasswordAlert]
    
    //MARK: WELCOME LABEL
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
    
    //MARK: LOGO
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo7")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - REG BUTTON
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = buttonsRadius
        button.layer.borderWidth = 1.5
        button.addTarget(self, action: #selector(endRegistration), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - TEXTS FEIELDS
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.cornerRadius = buttonsRadius
        textField.borderStyle = .none
        textField.placeholder = "Введите Имя"
        textField.layer.borderWidth = 1.5
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = buttonsRadius
        textField.borderStyle = .none
        textField.placeholder = "Введите Почту"
        textField.layer.borderWidth = 1.5
        textField.backgroundColor = .white
        return textField
    }()
    
    //MARK: - PASSWORD
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.cornerRadius = buttonsRadius
        textField.borderStyle = .none
        textField.placeholder = "Введите Пароль"
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var confinrmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.cornerRadius = buttonsRadius
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = "Подтвердите Пароль"
        textField.layer.borderWidth = 1.5
        textField.backgroundColor = .white
        return textField
    }()
    
    //MARK: - STACKVIEW
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameTextField, emailTextField, passwordTextField, confinrmPasswordTextField])
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
    
    //MARK: - SETUP
    func setupAll(){
        setupLabel(welcomLabel)
        setupStackView(stackView)
        setupRegButton(registrationButton)
        setupLogo()
    }
    
    //MARK: - SETUP LABEL
    func setupLabel(_ label: UILabel) {
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8).isActive = true
        label.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.08).isActive = true
    }
    
    //MARK: - SETUP STACKVIEW
    func setupStackView(_ stackView: UIStackView) {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomLabel.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7),
            stackView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.35)])
    }
    
    func setupRegButton(_ button: UIButton) {
        view.addSubview(button)
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        button.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.07).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7).isActive = true
    }
    //MARK: - SETUP LOGO
    func setupLogo() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: registrationButton.topAnchor, constant: -35),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.bounds.width * 0.025),
            logoImageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.45),
            logoImageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.14)])
    }
    
    //MARK: - TARGETS
    @objc func endRegistration() {
        if checkingAll() {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - CHECK ALL FIELDS
    
    func checkingAll() -> Bool {
        let checkingArray = [checkAll.checkUserName(userNameTextField.text),
                             checkAll.checkEmail(emailTextField.text),
                             checkAll.checkPassword(passwordTextField.text),
                             checkAll.checkEqualPasswords(passwordTextField.text, confinrmPasswordTextField.text)]
        for i in 0..<checkingArray.count {
            if !checkingArray[i] {
                showAlert(alert: alertsArray[i])
                return  false
            }
        }
        return true
    }
    
    //MARK: - SHOW ALERTS
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
}

//MARK: - EXTENSION
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
