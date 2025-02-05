//
//  PayView.swift
//  EDS_Store
//
//  Created by Илья Морозов on 05.02.2025.
//

import UIKit

class PayView: UIViewController, UserDataViewProtocol {
    
    var presenter: (any UserDataPresenterProtocol)?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func saveData() {
        
    }
    
    func loadData() {
        
    }
    
    func success() {
        
    }
    
    func failure(error: UserDataError) {
    
    }
}
