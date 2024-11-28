//
//  EmailViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 28.11.2024.
//

import UIKit

class EmailViewController: UIViewController {

    private lazy var emailView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Почта"
        label.font = .boldSystemFont(ofSize: .init(25))
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите почту"
        if let email = user1Data.email {
            textField.text = email
        }
        textField.delegate = self
        textField.textAlignment = .right
        return textField
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Почта:"
        label.textColor = .black
        label.font = .systemFont(ofSize: 19)
        return label
    }()
    
    private lazy var safeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .orange
        button.setTitle("Cохранить почту", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(safeEmail), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmailView()
        setupAll()
        // Do any additional setup after loading the view.
    }
    
    func setupEmailView() {
        view.addSubview(emailView)
        emailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([emailView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     emailView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
                                     emailView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
                                     emailView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.5)])
    }
    
    func setupAll() {
        setupTitleLabel(titleLabel)
        setupCloseButton(closeButton)
        setupEmailLabel(emailLabel)
        setupTextField(emailTextField)
        setupSafeButton(safeButton)
    }

    func setupTitleLabel(_ label: UILabel) {
        emailView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 5),
                                     label.heightAnchor.constraint(equalToConstant: 30),
                                     label.widthAnchor.constraint(equalToConstant: 100)])
        
    }
    
    func setupCloseButton(_ button: UIButton) {
        emailView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 5),
                                     button.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 5),
                                     button.heightAnchor.constraint(equalToConstant: 40),
                                     button.widthAnchor.constraint(equalToConstant: 40)])
    }
    
    func setupEmailLabel(_ label: UILabel) {
        emailView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 10),
                                     label.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 15),
                                     label.heightAnchor.constraint(equalToConstant: 40),
                                     label.widthAnchor.constraint(equalToConstant: 100)])
    }
    
    func setupTextField(_ textField: UITextField) {
        emailView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textField.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -10),
                                     textField.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor),
                                     textField.heightAnchor.constraint(equalToConstant: 40),
                                     textField.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 30)])
                                    
    }
    
    func setupSafeButton(_ button: UIButton) {
        emailView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.centerXAnchor.constraint(equalTo: emailView.centerXAnchor),
                                     button.bottomAnchor.constraint(equalTo: emailView.bottomAnchor, constant: -20),
                                     button.widthAnchor.constraint(equalTo: emailView.widthAnchor, multiplier: 0.6),
                                     button.heightAnchor.constraint(equalTo: emailView.widthAnchor, multiplier: 0.15)])
    }
    
    @objc func safeEmail() {
        if let email = emailTextField.text {
            user1Data.email = email
        }
        dismiss(animated: true)
    }
    
    @objc func closeView() {
        dismiss(animated: true)
    }
}


extension EmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
