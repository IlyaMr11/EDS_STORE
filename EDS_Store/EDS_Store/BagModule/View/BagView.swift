//
//  BagView.swift
//  EDS_Store
//
//  Created by Илья Морозов on 19.01.2025.
//

import UIKit

protocol BagViewProtocol: AnyObject {
    func success(array: [(Product, Int)])
    func failure(alert: AlertType)
    func loadImages(imageArray: [UIImage])
}


class BagView: UIViewController, BagViewProtocol {
    
    private let yPosition: CGFloat = 100
    
    var presenter: BagPresenterProtocol?
    var bagArray: [(Product, Int)] = []
    var imageArray: [UIImage] = []
    
    lazy var bagTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(BagTableViewCell.self, forCellReuseIdentifier: BagTableViewCell.identifier)
        table.separatorStyle = .none
        return table
    }()
    
    
    lazy var finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Заказать:", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        //button.addTarget(self, action: #selector(finishOrder), for: .touchUpInside)
        return button
    }()
    
    let buttonRadius = CGFloat(15)
    
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
        title = "Корзина"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupUI()
        presenter?.setupData()
    }
    
    func success(array: [(Product, Int)]) {
        self.bagArray = array
        bagTableView.reloadData()
        presenter?.setupImages(array: array)
        print(bagArray)
    }
    
    func loadImages(imageArray: [UIImage]) {
        self.imageArray = imageArray
        bagTableView.reloadData()
    }
    
    func failure(alert: AlertType) {
        imageArray = []
        bagArray = []
        bagTableView.reloadData()
        switch alert {
        case .emptyBasket:
           setupEmptyBag()
        default:
            present(alert.alert, animated: true)
        }
        
    }
    
    func setupUI() {
        setupTable()
        setupFinishButton()
    }
    
    
    @objc func toHomeVC() {
        self.tabBarController?.selectedIndex = 0
    }
    
    
    func setupTable() {
        view.addSubview(bagTableView)
        bagTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bagTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            bagTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bagTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bagTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func setupFinishButton() {
        
    }
    
    func setupEmptyBag() {
        setupEmptyBagImageView(emptyBagImageView)
        setupEmptyBagLabel(emptyBagLabel)
        setupHintLabel(hintLabel)
        setupToHomeVCButton(toHomeVCButton)
    }
    
    
    func setupEmptyBagImageView(_ imageView: UIImageView) {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -15),
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

    
}

extension BagView: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bagArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BagTableViewCell.identifier, for: indexPath) as! BagTableViewCell
        cell.configure(with: bagArray[indexPath.row])
        cell.index = indexPath.row
        if imageArray.count > indexPath.row {
            cell.loadPhoto(image: imageArray[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY > yPosition {
            self.navigationItem.largeTitleDisplayMode = .never
        } else {
            self.navigationItem.largeTitleDisplayMode = .always
        }
        
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.layoutIfNeeded()
        }
    }
}
