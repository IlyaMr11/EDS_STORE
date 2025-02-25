//
//  ConfirmView.swift
//  EDS_Store
//
//  Created by Илья Морозов on 23.02.2025.
//

import UIKit

protocol ConfirmViewProtocol: AnyObject {
    func success(order: OrderData)
    func failure(alert: AlertType)
    func setupAddress(_ array: [String])
}


class ConfirmView: UIViewController, ConfirmViewProtocol {
    
    var presenter: ConfirmPresenterProtocol?
    var images: [UIImage] = []
    var total = 0
    var count = 0
    var addresses: [String] = []
    
    let labelColor: UIColor = .darkGray
    let chosePay = ["Наличными", "Картой при получении"]
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
//        scrollView.isDirectionalLockEnabled = false
        return scrollView
    }()
    
    var contentView: UIView!
    
    var price: UILabel!
    var titleLabel: UILabel!
    
    private lazy var addressView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес доставки"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = labelColor
        return label
    }()
    
    private lazy var addressButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitle("Добавьте адрес", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapAddressButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var productView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 150)
        layout.minimumLineSpacing = 15 // Расстояние между строками
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var productLabel: UILabel = {
        let label = UILabel()
        label.text = "Товары"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = labelColor
        return label
    }()
    
    private lazy var paymentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var paymentLabel: UILabel = {
        let label = UILabel()
        label.text = "Спопсоб оплаты"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = labelColor
        return label
    }()
    
    private lazy var payTable: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var totalView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Итого"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.textColor = labelColor
        return label
    }()
    
    private lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Доставка"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = labelColor
        return label
    }()
    
    private lazy var productTotal: UILabel = {
        let label = UILabel()
        label.text = "\(count) товара на сумму"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = labelColor
        return label
    }()
    
    private lazy var totalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [totalLabel, productTotal, deliveryLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var totalPrice: UILabel = {
        let label = UILabel()
        label.text = "\(total) ₽"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    private lazy var deliveryPrice: UILabel = {
        let label = UILabel()
        label.text = "0 ₽"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    private lazy var productPrice: UILabel = {
        let label = UILabel()
        label.text = "\(total) ₽"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    private lazy var priceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [totalPrice, productPrice, deliveryPrice])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Заказ"
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadProducts()
        loadAddress()
    }
    
    func loadProducts() {
        presenter?.loadData()
    }
    
    func loadAddress() {
        presenter?.laodAddress()
    }
    
    @objc func didTapAddressButton() {
        
    }
    
    func success(order: OrderData) {
        images = order.images
        total = order.total
        count = order.count
        collectionView.reloadData()
        updateUI()
    }
    
    func failure(alert: AlertType) {
       showAlert(alert: alert.alert)
    }

    func setupUI() {
        setupScrollView()
        createContentView()
        setupAddress()
        setupProduct()
        setupPayment()
        setupTotal()
    }
    
    func setupAddress(_ array: [String]) {
        addresses = array
        addressButton.setTitle("\(addresses[0])", for: .normal)
    }
    
    func updateUI() {
        productPrice.text = "\(total) ₽"
        totalPrice.text = "\(total) ₽"
        productTotal.text = "\(count) товаров на сумму"
        price.text = "\(total) ₽"
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    func createContentView() {
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 870)
        ])
    }
    
    func configAdress() {
        setupLabel(parent: addressView, label: addressLabel)
        
        addressView.addSubview(addressButton)
        addressButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            addressButton.bottomAnchor.constraint(equalTo: addressView.bottomAnchor, constant: -10),
            addressButton.leftAnchor.constraint(equalTo: addressView.leftAnchor, constant: 10),
            addressButton.rightAnchor.constraint(equalTo: addressView.rightAnchor, constant: -10)])
    }
    
    func setupAddress() {
        contentView.addSubview(addressView)
        addressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            addressView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            addressView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            addressView.heightAnchor.constraint(equalToConstant: 110)])
        
        configAdress()
    }
    
    func configProduct() {
        setupLabel(parent: productView, label: productLabel)
        
        productView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: productView.leftAnchor, constant: 15),
            collectionView.rightAnchor.constraint(equalTo: productView.rightAnchor, constant: -15),
            collectionView.heightAnchor.constraint(equalToConstant: 150)])
        
    }
    
    func setupProduct() {
        contentView.addSubview(productView)
        productView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productView.topAnchor.constraint(equalTo: addressView.bottomAnchor, constant: 25),
            productView.leftAnchor.constraint(equalTo: addressView.leftAnchor),
            productView.rightAnchor.constraint(equalTo: addressView.rightAnchor),
            productView.heightAnchor.constraint(equalToConstant: 230)])
        
        configProduct()
    }
    
    func configPayement() {
        setupLabel(parent: paymentView, label: paymentLabel)
        
        contentView.addSubview(payTable)
        payTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            payTable.topAnchor.constraint(equalTo: paymentLabel.bottomAnchor, constant: 15),
            payTable.leftAnchor.constraint(equalTo: paymentView.leftAnchor, constant: 10),
            payTable.rightAnchor.constraint(equalTo: paymentView.rightAnchor, constant: -10),
            payTable.heightAnchor.constraint(equalToConstant: 100)])
    }
    
    func setupPayment() {
        contentView.addSubview(paymentView)
        paymentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paymentView.topAnchor.constraint(equalTo: productView.bottomAnchor, constant: 25),
            paymentView.leftAnchor.constraint(equalTo: productView.leftAnchor),
            paymentView.rightAnchor.constraint(equalTo: productView.rightAnchor),
            paymentView.heightAnchor.constraint(equalToConstant: 170)])
        
        configPayement()
    }
    
    func setupLabel(parent: UIView, label: UILabel) {
        parent.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: parent.topAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: parent.leftAnchor),
            label.rightAnchor.constraint(equalTo: parent.rightAnchor),
            label.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    func configTotal() {
        totalView.addSubview(totalStack)
        totalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalStack.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 15),
            totalStack.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 15),
            totalStack.widthAnchor.constraint(equalToConstant: 200),
            totalStack.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        totalView.addSubview(priceStack)
        priceStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceStack.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 15),
            priceStack.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -15),
            priceStack.widthAnchor.constraint(equalToConstant: 150),
            priceStack.heightAnchor.constraint(equalToConstant: 100)])
    }
    
    func setupTotal() {
        contentView.addSubview(totalView)
        totalView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalView.topAnchor.constraint(equalTo: paymentView.bottomAnchor, constant: 25),
            totalView.leftAnchor.constraint(equalTo: paymentView.leftAnchor),
            totalView.rightAnchor.constraint(equalTo: paymentView.rightAnchor),
            totalView.heightAnchor.constraint(equalToConstant: 210)])
        
        configTotal()
        configButton()
    }
    
    func configButton() {
        totalView.addSubview(orderButton)
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            orderButton.topAnchor.constraint(equalTo: totalStack.bottomAnchor, constant: 20),
            orderButton.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -10),
            orderButton.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 10),
            orderButton.heightAnchor.constraint(equalToConstant: 60)])
        
        // Создаем метку для надписи "Заказать"
        titleLabel = UILabel()
        titleLabel.text = "Заказать"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Создаем метку для отображения суммы покупки
        price = UILabel()
        price.text = "\(total) ₽"
        price.font = .systemFont(ofSize: 20, weight: .bold)
        price.textColor = .white
        price.textAlignment = .right
        price.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем метки в кнопку
        orderButton.addSubview(titleLabel)
        orderButton.addSubview(price)
        
        // Устанавливаем констрейнты для меток
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: orderButton.leadingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: orderButton.centerYAnchor),
            
            price.trailingAnchor.constraint(equalTo: orderButton.trailingAnchor, constant: -15),
            price.centerYAnchor.constraint(equalTo: orderButton.centerYAnchor)
        ])
    }
}


extension ConfirmView: UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        cell.textLabel?.text = chosePay[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        cell.textLabel?.textColor = .black
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.cornerRadius = 10
        cell.layer.backgroundColor = UIColor.systemGray4.cgColor
        cell.selectionStyle = .none
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let image = UIImageView(image: images[indexPath.row])
        cell.backgroundColor = .white
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем UIImageView в ячейку
        cell.contentView.addSubview(image)
        
        // Настраиваем констрейнты для изображения
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        
        // Настраиваем скругление углов
        cell.layer.cornerRadius = 8
        cell.contentView.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.layer.borderColor = UIColor.orange.cgColor
            cell.backgroundColor = .white
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.layer.borderColor = UIColor.clear.cgColor
            cell.backgroundColor = .systemGray4
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY > 100 {
            navigationItem.largeTitleDisplayMode = .never
        } else {
            navigationItem.largeTitleDisplayMode = .always
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
