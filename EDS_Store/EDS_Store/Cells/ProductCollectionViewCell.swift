//
//  ProductCollectionViewCell.swift
//  EDS_Store
//
//  Created by Илья Морозов on 27.02.2025.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    var backView: UIView!
    
    var productImageView: UIImageView!
    
    var nameLabel: UILabel!
    
    var priceLabel: UILabel!
    
    var countLabel: UILabel!
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        setupBackView()
        setupProductImageView()
        setupNameLabel()
        setupPriceLabel()
        setupCountLabel()
    }
    
    func configure(_ purchase: Purchase) {
        let count = purchase.count
        let product = purchase.product
        nameLabel.text = product.name
        countLabel.text = "\(count) шт."
        priceLabel.text = "\(product.price) ₽"
    }
    
    func setupBackView() {
        backView = UIView()
        backView.backgroundColor = .systemBackground
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
        
        contentView.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupProductImageView() {
        productImageView = UIImageView()
        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 10
        productImageView.backgroundColor = .white
        
        backView.addSubview(productImageView)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: backView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .black
        nameLabel.adjustsFontSizeToFitWidth = true
        
        backView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 3),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)])
    }
    
    func setupPriceLabel() {
        priceLabel = UILabel()
        priceLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .left
        
        backView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3)
            ])
            
    }
    
    func setupCountLabel() {
        countLabel = UILabel()
        countLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        countLabel.textColor = .black
        countLabel.textAlignment = .left
        
        backView.addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            countLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            countLabel.heightAnchor.constraint(equalToConstant: 20),
            countLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 3)
            ])
    }
}
