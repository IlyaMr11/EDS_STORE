//
//  DeliveryTableViewCell.swift
//  EDS_Store
//
//  Created by Илья Морозов on 27.02.2025.
//

import UIKit

class DeliveryTableViewCell: UITableViewCell {

    let identifier: String = "DeliveryTableViewCell"
    
    var backView = UIView()
    
    var priceLabel = UILabel()
    
    var totalLabel = UILabel()
    
    var countLabel = UILabel()
    
    var collectionView: UICollectionView!
    
    var positions: [Purchase] = []
    
    var dateLabel = UILabel()
    
    var addressLabel =  UILabel()
    
    var productCountLabel = UILabel()
    
    var imageArray:  [UIImage] = []

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(_ array: [Purchase]) {
        self.positions = array
        updateTotalCount()
        updateCollection()
        updateAddress()
        updateDate()
    }
    
    func setupImage(_ array: [UIImage]) {
        imageArray = array
        collectionView.reloadData()
    }
    
    func updateTotalCount() {
        var cnt = 0
        var total = 0
        for pur in positions {
            cnt += pur.count
            total += pur.count * (Int(pur.product.price) ?? 0)
        }
        totalLabel.text = "\(total) ₽"
        productCountLabel.text = "\(cnt) шт."
    }
    
    func updateAddress() {
        if positions.count > 0 {
            addressLabel.text = positions[0].address
        }
    }
    
    func updateDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm" // Формат даты
        dateFormatter.timeZone = TimeZone(identifier: "Russia/Moscow")
        let date = dateFormatter.string(from: positions[0].date)
        if positions.count > 0 {
            dateLabel.text = date
        }
    }
    
    func updateCollection() {
        collectionView.reloadData()
    }
    
    func setupUI() {
        setupView()
        setupDateLabel()
        setupCollectionView()
        setupAddressLabel()
        setupPriceLabel()
        setupCountLabel()
        setupTotalLabel()
        setupProductCountLabel()
    }

    func setupView() {
        backView = UIView()
        backView.backgroundColor = .systemGray5
        backView.layer.cornerRadius = 20
        contentView.addSubview(backView)
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 250)
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray5
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        backView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalToConstant: 250),
            collectionView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            collectionView.centerXAnchor.constraint(equalTo: backView.centerXAnchor)
        ])
    }

    func setupDateLabel() {
        dateLabel = UILabel()
        dateLabel.textColor = .darkGray
        dateLabel.textAlignment = .center
        dateLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        backView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func setupAddressLabel() {
        addressLabel = UILabel()
        addressLabel.textColor = .black
        addressLabel.textAlignment = .left
        addressLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        backView.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 20),
            addressLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func setupPriceLabel() {
        priceLabel = UILabel()
        priceLabel.textColor = .darkGray
        priceLabel.text = "Сумма:"
        priceLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        backView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            priceLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            priceLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    func setupCountLabel() {
        countLabel = UILabel()
        countLabel.textColor = .darkGray
        countLabel.text = "Количество:"
        countLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        backView.addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countLabel.heightAnchor.constraint(equalToConstant: 20),
            countLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            countLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            countLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    func setupTotalLabel() {
        totalLabel = UILabel()
        totalLabel.textColor = .black
        totalLabel.font = .systemFont(ofSize: 20, weight: .bold)
        totalLabel.textAlignment = .right
        
        backView.addSubview(totalLabel) // Добавляем totalLabel в иерархию view
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor),
            totalLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            totalLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 20)
        ])
    }

    func setupProductCountLabel() {
        productCountLabel = UILabel()
        productCountLabel.textColor = .black
        productCountLabel.font = .systemFont(ofSize: 20, weight: .bold)
        productCountLabel.textAlignment = .right
        
        backView.addSubview(productCountLabel) // Добавляем productCountLabel в иерархию view
        productCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productCountLabel.topAnchor.constraint(equalTo: countLabel.topAnchor),
            productCountLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            productCountLabel.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 20)
        ])
    }
    
}

extension DeliveryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return positions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ProductCollectionViewCell
        cell.configure(positions[indexPath.row])
        if indexPath.row < imageArray.count {
            cell.productImageView.image = imageArray[indexPath.row]
        }
        return cell
    }
}
