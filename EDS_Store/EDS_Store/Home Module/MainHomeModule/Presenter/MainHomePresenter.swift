//
//  MainHomePresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 12.01.2025.
//

import UIKit

protocol MainHomePresenterProtocol {
    init(view: MainHomeViewProtocol, router: HomeRouterProtocol, model:  MainHomeModelProtocol)
    func showProductDetail(_ product: Product, _ iamge: UIImage)
    func showProductData()
    func setupPicture(_ products: (Product, Product), cell: MainHomeTableViewCell)
}

class MainHomePresenter: MainHomePresenterProtocol {
    
    
    let model: MainHomeModelProtocol
    var router: HomeRouterProtocol?
    var view: MainHomeViewProtocol?
    
    required init(view: any MainHomeViewProtocol, router: any HomeRouterProtocol, model: any MainHomeModelProtocol) {
        self.model = model
        self.router = router
        self.view = view
    }
    
    //MARK: - SHOW PRODUCT DATA
    func showProductData()  {
        self.model.firebaseService.getProductData { [weak self] (products, alert) in
            if let alert = alert {
                DispatchQueue.main.async {
                    self?.view?.failure(alert: alert)
                }
                return
            }
                
            guard let products = products else {
                DispatchQueue.main.async {
                    self?.view?.failure(alert: .noData)
                }
                return
            }
            
    
            var productArr = [(Product, Product)]()
            for index in stride(from: 1, to: products.count, by: 2) {
                productArr.append((products[index], products[index + 1]))
            }
            print(products.count)
            
            DispatchQueue.main.async {
                self?.view?.configureTable(productArray: productArr)
            }
            
        }
    }
    
    //MARK: - SHOW PRODUCT DETAIL
    func showProductDetail(_ product: Product, _ image: UIImage) {
        router?.showProductDetails(product: product, image: image)
    }
    
    //MARK: - SETUP PICTUTRE
    func setupPicture(_ proudcts: (Product, Product), cell: MainHomeTableViewCell) {
        let path1 = proudcts.0.picture
        let path2 = proudcts.1.picture
        NetworkLayer.loadPhoto(path: path1) { (image, text) in
            if let text = text {
                print(text)
                return
            }
            
            if let image = image {
                DispatchQueue.main.async {
                    cell.productImage.image = image
                    cell.image1 = image
                    cell.product1 = proudcts.0
                }
            }
        }
        
        NetworkLayer.loadPhoto(path: path2) { (image, text) in
            if let text = text {
                print(text)
                return
            }
            
            if let image = image {
                DispatchQueue.main.async {
                    cell.secondProductImage.image = image
                    cell.image2 = image
                    cell.product2 = proudcts.1
                }
            }
        }
    }
}
