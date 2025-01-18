//
//  ProductPagePresenter.swift
//  EDS_Store
//
//  Created by Илья Морозов on 18.01.2025.
//

import UIKit

protocol ProductPagePresenterProtocol {
    init(view: ProductPageViewProtocol, router: HomeRouterProtocol, model: ProductPageModelProtocol)
}
    
class ProductPagePresenter: ProductPagePresenterProtocol {
    
    
    weak var view: ProductPageViewProtocol?
    var router: HomeRouterProtocol?
    let model: ProductPageModelProtocol
    
    required init(view:  ProductPageViewProtocol, router: any HomeRouterProtocol, model: any ProductPageModelProtocol) {
        self.model = model
        self.router = router
        self.view = view
    }
    
}
