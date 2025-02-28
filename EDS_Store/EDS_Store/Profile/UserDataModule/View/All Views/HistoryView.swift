//
//  HistoryViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 30.11.2024.
//

import UIKit

class HistoryView: UIViewController, UserDataViewProtocol {
    
    var presenter: (any UserDataPresenterProtocol)?
    var images = [[UIImage]]()
    
    
    let identifier = "DeliveryCell"
    //MARK: - CONSTANTS
    let viewRadius = CGFloat(20)
    let buttonRadius = CGFloat(15)
    let color1 = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
    var purchases: [[Purchase]] = []
    
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
    
    
    private lazy var historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(DeliveryTableViewCell.self, forCellReuseIdentifier: identifier)
        return tableView
    }()
    
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "История"
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    func setupUI() {
        presenter?.loadUserData(attr: .history)
    }
    
    func setupEmptyHistory() {
        setupBackView()
        setupAll()
    }
    
    func setupImages(_ array: [[UIImage]]) {
        images = array
        setupTableView()
    }
    
    func saveData() {
        
    }
    
    func setupData(data: Any) {
        if let array = data as? [[UIImage]] {
            setupImages(array)
            return
        }
        
        if let array = data as? [Date: [Purchase]] {
            if array.isEmpty {
                setupEmptyHistory()
                return
            }
            purchases = sortData(map: array)
            success()
            presenter?.loadPhoto(array: purchases)
        }
    }
    
    
    func sortData(map: [Date: [Purchase]]) -> [[Purchase]] {
        let keys = map.keys.sorted()
        var pur = [[Purchase]]()
        for i in keys {
            if let v = map[i] {
                pur.append(v)
            }
        }
        return pur
    }
    
    func failure(error: AlertType) {
        showAlert(alert: error.alert)
    }
    
    func success() {
        historyTableView.reloadData()
    }
    
    //MARK: - TARGETS
    @objc func toHomeVC() {
        AppCordinator.shared.showHomeModule()
    }
    
    func setupTableView() {
        view.addSubview(historyTableView)
        historyTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)])
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
        backView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 20),                              button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     button.heightAnchor.constraint(equalToConstant: 50),
                                     button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.6)])
    }
}


extension HistoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! DeliveryTableViewCell
        cell.configure(purchases[indexPath.row])
        if indexPath.row < images.count {
            cell.setupImage(images[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 410
    }
}
