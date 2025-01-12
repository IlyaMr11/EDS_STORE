//
//  HistoryViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 30.11.2024.
//

import UIKit

protocol HistoryViewProtocol: AnyObject {
    func success()
    func failure()
}

class HistoryView: UIViewController {

    var presenter: HistoryPresenterProtocol?
    
    //MARK: - CONSTANTS
    let buttonRadius = CGFloat(15)
    let viewRadius = CGFloat(25)
    let color1 = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
    
    //MARK: - EMPTY HISTORY IMAGE
    private lazy var emptyHistoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "emptyHistory")
        return imageView
    }()
    
    //MARK: - HINT LABEL
    private lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы еще не оформили ни одного заказа"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - TO HOME VC BUTTON
    private lazy var toHomeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти в каталог", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = buttonRadius
        button.addTarget(self, action: #selector(toHomeVC), for: .touchUpInside)
        return button
    }()
    
    //MARK: - TITLE LABEL
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "История заказов пуста"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - STACK VIEW OF LABELS
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, hintLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: - BACK VIEW
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = color1
        view.layer.cornerRadius = viewRadius
        return view
    }()
    
    //MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "История заказов"
        setupBackView()
        setupAll()
    }
    
    //MARK: - SETUP BACK VIEW
    func setupBackView() {
        view.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([backView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     backView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     backView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
                                     backView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.75)])
    }
    
    //MARK: - SETUP ALL UI OBJ
    func setupAll() {
       setupEmptyHistoryImage(emptyHistoryImageView)
       setupStackView(labelStackView)
       setupHomeVCButton(toHomeButton)
    }
    
    func setupEmptyHistoryImage(_ emptyImage: UIImageView) {
        backView.addSubview(emptyImage)
        emptyImage.translatesAutoresizingMaskIntoConstraints = false
        emptyImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10).isActive = true
        emptyImage.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        emptyImage.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.15).isActive = true
        emptyImage.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.35).isActive = true
    }
    
    func setupStackView(_ stackView: UIStackView) {
        backView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: emptyHistoryImageView.bottomAnchor, constant: 20),
                                     stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     stackView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.07),
                                     stackView.widthAnchor.constraint(equalTo: view.widthAnchor)])
    }
    
    func setupHomeVCButton(_ button: UIButton) {
        emptyHistoryImageView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 20),                              button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     button.heightAnchor.constraint(equalToConstant: 50),
                                     button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.6)])
    }
    
    //MARK: - TARGETS
    @objc func toHomeVC() {
        self.tabBarController?.selectedIndex = 0
    }
}

extension HistoryView: HistoryViewProtocol {
    func success() {
        
    }
    
    func failure() {
        
    }
    
}
