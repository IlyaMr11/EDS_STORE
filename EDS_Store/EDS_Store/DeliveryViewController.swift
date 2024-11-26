//
//  DeliveryViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 26.11.2024.
//

import UIKit

class DeliveryViewController: UIViewController {
    
    let color1 = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
    
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет текущих доставок"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: .init(22))
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var emptyDeliveryView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = color1
        return view
    }()
    
    private lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.text = "Закажите товары из каталога!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: .init(16))
        return label
    }()
    
    private lazy var toHomeVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти в каталог", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = .systemFont(ofSize: .init(14))
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(toHomeVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var emptyDeliveryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "emptyTruck")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Доставки"
        
    
        setupEmptyDelivery()
        // Do any additional setup after loading the view.
    }
    
    
    func setupEmptyDelivery() {
        setupEmptyDeliveryView(emptyDeliveryView)
    }
    
    func setupEmptyDeliveryView(_ emptyView: UIView) {
        view.addSubview(emptyView)
        emptyView.frame = CGRect(x: 0, y: 0, width: view.bounds.width * 0.75, height: view.bounds.height / 3)
        emptyView.center = view.center
        setupEmptyDeliveryImage(emptyDeliveryImage)
        setupEmptyDeliveryLabel(warningLabel)
        setupHintLabel(hintLabel)
        setupHomeVCButton(toHomeVCButton)
    }
    
    func setupEmptyDeliveryImage(_ emptyImage: UIImageView) {
        emptyDeliveryView.addSubview(emptyImage)
        emptyImage.translatesAutoresizingMaskIntoConstraints = false
        emptyImage.topAnchor.constraint(equalTo: emptyDeliveryView.topAnchor, constant: 10).isActive = true
        emptyImage.centerXAnchor.constraint(equalTo: emptyDeliveryView.centerXAnchor).isActive = true
        emptyImage.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.15).isActive = true
        emptyImage.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.35).isActive = true
    }
    
    func setupEmptyDeliveryLabel(_ label: UILabel) {
        emptyDeliveryView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: emptyDeliveryImage.bottomAnchor, constant: 10),                              label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.heightAnchor.constraint(equalToConstant: 30),
                                     label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.6)])
    }
    
    func setupHintLabel(_ label: UILabel) {
        emptyDeliveryView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 10),                          label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 25),
            label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.6)])
    }
    
    func setupHomeVCButton(_ button: UIButton) {
        emptyDeliveryView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 10),                              button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     button.heightAnchor.constraint(equalToConstant: 50),
                                     button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.6)])
    }
                                    
    @objc func toHomeVC() {
        self.tabBarController?.selectedIndex = 0
    }
}
