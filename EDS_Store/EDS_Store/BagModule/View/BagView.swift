//
//  BagView.swift
//  EDS_Store
//
//  Created by Илья Морозов on 19.01.2025.
//

import UIKit

protocol BagViewProtocol: AnyObject {
    func success(array: [(Product, Int)])
    func failure(alert: UIAlertController)
    func loadImages(imageArray: [UIImage])
}


class BagView: UIViewController, BagViewProtocol {
    
    var presenter: BagPresenterProtocol?
    var bagArray: [(Product, Int)] = []
    var imageArray: [UIImage] = []
    
    lazy var bagTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(BagTableViewCell.self, forCellReuseIdentifier: BagTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Корзина"
        setupUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.pushBasketToView()
    }
    
    func success(array: [(Product, Int)]) {
        self.bagArray = array
        bagTableView.reloadData()
        print(bagArray)
    }
    
    func loadImages(imageArray: [UIImage]) {
        self.imageArray = imageArray
        bagTableView.reloadData()
    }
    
    func failure(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func setupUI() {
        view.addSubview(bagTableView)
        bagTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bagTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            bagTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bagTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bagTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
}

extension BagView: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bagArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BagTableViewCell.identifier, for: indexPath) as! BagTableViewCell
        cell.configure(with: bagArray[indexPath.row])
        if imageArray.count > indexPath.row {
            cell.loadPhoto(image: imageArray[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
