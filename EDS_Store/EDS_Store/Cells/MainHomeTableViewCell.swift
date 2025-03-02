//
//  MainHomeTableViewCell.swift
//  EDS_Store
//
//  Created by Илья Морозов on 14.01.2025.
//

import UIKit

class MainHomeTableViewCell: UITableViewCell {
    static let identifier: String = "mainHomeCell"

    var product1: Product?
    var product2: Product?
    var presenter: MainHomePresenterProtocol?
    var image1: UIImage?
    var image2: UIImage?
    
    private lazy var productView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var secondProductView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "title"
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var secondTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "gebe"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var secondPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var secondProductImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var bagButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .orange
        button.layer.cornerRadius = 15
        button.setImage(UIImage(systemName: "basket"), for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(pressProduct(_:)), for: .touchUpInside)
        button.addTarget(ButtonAnimations.shared, action: #selector(ButtonAnimations.comeback(sender:)), for: .touchUpInside)
        button.addTarget(ButtonAnimations.shared, action: #selector(ButtonAnimations.littleAndAlpha(sender:)), for: .touchDown)
        return button
    }()
    
    private lazy var secondBagButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .orange
        button.layer.cornerRadius = 15
        button.setImage(UIImage(systemName: "basket")?.withTintColor(.white), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(pressProduct(_:)), for: .touchUpInside)
        button.addTarget(ButtonAnimations.shared, action: #selector(ButtonAnimations.littleAndAlpha(sender:)), for: .touchDown)
        return button
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        contentView.backgroundColor = .systemGray3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let v1 = createProduct(prView: productView, image: productImage, title: titleLabel, price: priceLabel, button: bagButton)
        let v2 = createProduct(prView: secondProductView, image: secondProductImage, title: secondTitleLabel, price: secondPriceLabel, button: secondBagButton)
        contentView.addSubview(v1)
        contentView.addSubview(v2)
        v1.translatesAutoresizingMaskIntoConstraints = false
        v2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([v1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7), v2.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7), v1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor), v2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor), v1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.482), v2.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.482), v1.leftAnchor.constraint(equalTo:  contentView.leftAnchor, constant: 5), v2.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5)])
    }
    
    func createProduct(prView: UIView, image: UIImageView, title: UILabel, price: UILabel, button: UIButton) -> UIView {
        setupImage(image, prView: prView)
        setupTitleLabel(title, prView: prView)
        setupPriceLabel(price, prView: prView)
        setupButton(button, prView: prView)
        return prView
    }
    
    func setupStackView(_ stackView: UIStackView) {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
                                    
    }
    
    func setupImage(_ aView: UIView, prView: UIView) {
        prView.addSubview(aView)
        aView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aView.topAnchor.constraint(equalTo: prView.topAnchor, constant: 5),
            aView.leadingAnchor.constraint(equalTo: prView.leadingAnchor),
            aView.trailingAnchor.constraint(equalTo: prView.trailingAnchor),
            aView.heightAnchor.constraint(equalTo: prView.heightAnchor, multiplier: 0.64)])
    }
    
    func setupTitleLabel(_ label: UIView, prView: UIView)  {
        prView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: prView.topAnchor, constant: 190),
            label.leadingAnchor.constraint(equalTo: prView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: prView.trailingAnchor),
            label.heightAnchor.constraint(equalTo: prView.heightAnchor, multiplier: 0.1)])
    }
    
    func setupPriceLabel(_ label: UIView, prView: UIView)  {
        prView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: prView.topAnchor, constant: 216),
            label.leadingAnchor.constraint(equalTo: prView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: prView.trailingAnchor),
            label.heightAnchor.constraint(equalTo: prView.heightAnchor, multiplier: 0.1)])
    }
    
    func setupButton(_ button: UIView, prView: UIView) {
        prView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: prView.bottomAnchor),
            button.centerXAnchor.constraint(equalTo: prView.centerXAnchor),
            button.widthAnchor.constraint(equalTo: prView.widthAnchor),
            button.heightAnchor.constraint(equalTo: prView.heightAnchor, multiplier: 0.16)])
    }
    
    func configure(with productTup: (Product, Product)) {
        titleLabel.text = productTup.0.name
        priceLabel.text = "Цена: \(productTup.0.price) р."
        secondTitleLabel.text = productTup.1.name
        secondPriceLabel.text = "Цена: \(productTup.1.price) р."
    }
    
    @objc func pressProduct(_ sender: UIButton) {
        guard let product = [product1, product2][sender.tag],
        let image = [image1, image2][sender.tag] else { print("no product"); return }
        print("hello")
        presenter?.showProductDetail(product, image)
    }
}
                         
