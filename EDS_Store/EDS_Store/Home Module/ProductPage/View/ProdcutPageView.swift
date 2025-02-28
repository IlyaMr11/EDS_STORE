//
//  ProdcutPageView.swift
//  EDS_Store
//
//  Created by Илья Морозов on 18.01.2025.
//

import UIKit

protocol ProductPageViewProtocol: UIViewController {
    var product: Product? { get set }
    var image: UIImage? { get set }
    func failure(alert: UIAlertController)
}

class ProductPageView: UIViewController, ProductPageViewProtocol {
    
    var presenter: ProductPagePresenterProtocol?
    var product: Product?
    var image: UIImage?
    let firstSection = ["Название: ", "Тип продукта - "]
    let identifier = "ProdcutPageView"
    let motorCells = ["Мощность: ", "Тип: ", "Размер: ", "Фланец: "]
    let reducerCells = ["Передачное число: ", "Тип: ", "Размер: ", "Фланец: "]
    
    //MARK: - VIEWS
    lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.text = "Цена    -     \(product?.price ?? "0") р."
        return label
    }()
    
    lazy var descriptionTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        table.dataSource = self
        return table
    }()
    
    private lazy var bagButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.setTitle("Добавить в корзину", for: .normal)
        button.layer.cornerRadius = 17
        button.titleLabel?.font = .systemFont(ofSize: 23, weight: .medium)
        button.addTarget(self, action: #selector(addProduct(sender:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Товар"
        self.view.backgroundColor = .white
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAll()
    }
    
    func failure(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    @objc func addProduct(sender: UIButton) {
        ButtonAnimations.growSize(layer: sender.layer)
        guard let product = self.product else { return }
        presenter?.addToBag(product: product)
    }
    
    func setupAll() {
        setupImageView(productImage)
        setupPriceLabel(priceLabel)
        setupButton(bagButton)
        setupTableView(descriptionTableView)
    }
    
    func setupImageView(_ imageView: UIImageView) {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.35)
        ])
    }

    func setupPriceLabel(_ label: UILabel) {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
    }

    func setupTableView(_ table: UITableView) {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: bagButton.topAnchor, constant: -10)
        ])
    }
        
    func setupButton(_ button: UIButton) {
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.heightAnchor.constraint(equalToConstant: view.frame.width*0.12),
                button.widthAnchor.constraint(equalToConstant: view.frame.width*0.7)])
    }
    
}


extension ProductPageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let product = self.product else { return 0 }
        if section == 0 {
            return 2
        }
        
        switch product.productType {
        case "reducer":
            return reducerCells.count
        case "motor":
            return motorCells.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        configureCell(cell, indexPath)
        cell.textLabel?.font = .systemFont(ofSize: 24)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ["Товар", "Характеристики"][section]
    }
    
    func configureCell(_ cell: UITableViewCell, _ indexPath: IndexPath) {
        guard let product = self.product else { return }
        let commonData = [product.name, product.productType]
        
        if indexPath.section == 0 {
            cell.textLabel?.text = firstSection[indexPath.row] + commonData[indexPath.row]
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            return
    }
        
        switch product.productType {
        case "reducer":
            guard let reducer = product as? Reducer else { return }
            let reducerData = [reducer.ratio, reducer.type, reducer.size, reducer.flange]
            cell.textLabel?.text = reducerCells[indexPath.row] + reducerData[indexPath.row]
            return
        case "motor":
            guard let motor = product as? Motor else { return }
            let motorData = [motor.power, motor.type, motor.size, motor.flange]
            cell.textLabel?.text = motorCells[indexPath.row] + motorData[indexPath.row]
            return
        default:
            return 
        }
    }
}



