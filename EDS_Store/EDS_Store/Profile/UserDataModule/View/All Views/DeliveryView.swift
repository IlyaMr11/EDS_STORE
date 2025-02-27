//
//  DeliveryViewController.swift
//  EDS_Store
//
//  Created by Илья Морозов on 26.11.2024.
//

import UIKit


class DeliveryView: UIViewController, UserDataViewProtocol {
    
    var presenter: (any UserDataPresenterProtocol)?
    var images = [[UIImage]]()
    
    
    let identifier = "DeliveryCell"
    //MARK: - CONSTANTS
    let viewRadius = CGFloat(20)
    let buttonRadius = CGFloat(15)
    let color1 = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
    var purchases: [[Purchase]] = []
    
    //MARK: - WARNING LABEL
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет текущих доставок"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: .init(20))
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - EMPTY DELIVERY VIEW
    private lazy var emptyDeliveryView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = color1
        return view
    }()
    
    //MARK: - HINT LABEL
    private lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.text = "Закажите товары из каталога!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: .init(16))
        return label
    }()
    
    //MARK: - TO HOME VC
    private lazy var toHomeVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти в каталог", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = .systemFont(ofSize: .init(17))
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(toHomeVC), for: .touchUpInside)
        return button
    }()
    
    //MARK: -  EMPTY DELI IMAGE VIEW
    private lazy var emptyDeliveryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "emptyTruck")
        return imageView
    }()
    
    //MARK: - DELIVER STACK VIEW
    private lazy var delivertStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [warningLabel, hintLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var deliverTableView: UITableView = {
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
        title = "Доставки"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }
    
    func setupUI() {
        presenter?.loadUserData(attr: .delivery)
    }
    
    func setupEmptyDelivery() {
        setupEmptyDeliveryView(emptyDeliveryView)
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
        deliverTableView.reloadData()
    }
    
    //MARK: - TARGETS
    @objc func toHomeVC() {
        self.tabBarController?.selectedIndex = 0
    }
    
    func setupTableView() {
        view.addSubview(deliverTableView)
        deliverTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deliverTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            deliverTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            deliverTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            deliverTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)])
    }
    
    func setupHomeVCButton(_ button: UIButton) {
        emptyDeliveryView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: delivertStackView.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.6)])
    }
      
    
    //MARK: - SETUP BACK VIEW
    func setupEmptyDeliveryView(_ emptyView: UIView) {
        view.addSubview(emptyView)
        emptyView.frame = CGRect(x: 0, y: 0, width: view.bounds.width * 0.8, height: view.bounds.height / 2.75)
        emptyView.center = view.center
        setupEmptyDeliveryImage(emptyDeliveryImage)
        setupStackView(delivertStackView)
        setupHomeVCButton(toHomeVCButton)
    }
    
    //MARK: - SETUP ALL UI OBJ
    func setupEmptyDeliveryImage(_ emptyImage: UIImageView) {
        emptyDeliveryView.addSubview(emptyImage)
        emptyImage.translatesAutoresizingMaskIntoConstraints = false
        emptyImage.topAnchor.constraint(equalTo: emptyDeliveryView.topAnchor, constant: 10).isActive = true
        emptyImage.centerXAnchor.constraint(equalTo: emptyDeliveryView.centerXAnchor).isActive = true
        emptyImage.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.15).isActive = true
        emptyImage.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.35).isActive = true
    }
    
    func setupStackView(_ stackView: UIStackView) {
        emptyDeliveryView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: emptyDeliveryImage.bottomAnchor, constant: 20),
                                     stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     stackView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.07),
                                     stackView.widthAnchor.constraint(equalTo: view.widthAnchor)])
    }
    
}

extension DeliveryView: UITableViewDelegate, UITableViewDataSource {
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
