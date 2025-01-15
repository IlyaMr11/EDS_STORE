//
//  MainHomePresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 12.01.2025.
//

import Foundation

protocol MainHomePresenterProtocol {
    init(view: MainHomeViewProtocol, router: HomeRouterProtocol, model:  MainHomeModelProtocol)
    func showProductData()
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
    
    func showProductData()  {
        self.model.networkService.getProductData { (products, text) in
            if let text = text {
                print(text)
                DispatchQueue.main.async {
                    print("show alert")
                }
                return
            }
                
            guard let products = products else {
                print("no data")
                return
            }
            
            print("hiii")
            var productArr = [(Product, Product)]()
            for index in stride(from: 0, to: products.count, by: 2) {
                if index + 1 < products.count {
                    productArr.append((products[index], products[index + 1]))
                }
            }
            print(products.count)
            
            DispatchQueue.main.async {
                self.view?.configureTable(productArray: productArr)
            }
            
        }
    }
}
