//
//  BookCollcetionViewCell.swift
//  EDS_Store
//
//  Created by Илья Морозов on 23.11.2024.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollcetionViewCell"
    
    lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    lazy var firstImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var secondImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var firstCellView: UIView = {
        let view = UIView()
        setupView(firstLabel, firstImageView, view)
        return view
    }()
    
    lazy var secondCellView: UIView = {
        let view = UIView()
        setupView(secondLabel, secondImageView, view)
        return view
    }()
    
    lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstCellView, secondCellView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView(cellStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(_ label: UILabel, _ imageView: UIImageView, _ view: UIView) {
        view.addSubview(label)
        view.addSubview(imageView)
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75)])
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)])
    }
    
    func setupStackView(_ stackView: UIStackView) {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
                                    
    }
}
