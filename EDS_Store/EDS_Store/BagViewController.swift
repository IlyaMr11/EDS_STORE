//
//  BagViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 19.11.2024.
//

import UIKit

class BagViewController: UIViewController {
    
    let buttonRadius = CGFloat(15)
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес доставки: ул. Рудневка 39, кв. 126"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var emptyBagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emptyBag")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var emptyBagLabel: UILabel = {
        let label = UILabel()
        label.text = "В корзине пусто"
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы пока не добавили товары"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var toHomeVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать покупки", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = buttonRadius
        button.addTarget(self, action: #selector(toHomeVC), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupEmptyBag()
        title = "Корзина"
    }
    
    func setupEmptyBag() {
        setupAddressLabel(addressLabel)
        setupEmptyBagImageView(emptyBagImageView)
        setupEmptyBagLabel(emptyBagLabel)
        setupHintLabel(hintLabel)
        setupToHomeVCButton(toHomeVCButton)
    }

    func setupAddressLabel(_ label: UILabel) {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                                     label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     label.heightAnchor.constraint(equalToConstant: 30)])
        
    }
    
    func setupEmptyBagImageView(_ imageView: UIImageView) {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 15),
                                     imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     imageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.2),
                                     imageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.5)])
    }
    
    func setupEmptyBagLabel(_ label: UILabel) {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: emptyBagImageView.bottomAnchor, constant: 10),
                                     label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.heightAnchor.constraint(equalToConstant: 30),
                                     label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.6)])
    }
    
    func setupHintLabel(_ label: UILabel) {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: emptyBagLabel.bottomAnchor, constant: 10),
                                     label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.heightAnchor.constraint(equalToConstant: 30),
                                     label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7)])
    }
    
    func setupToHomeVCButton(_ button: UIButton) {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant:  15),
                                     button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     button.heightAnchor.constraint(equalToConstant: 50),
                                     button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.4)])
    }
    
    @objc func toHomeVC() {
        self.tabBarController?.selectedIndex = 0
    }
}
