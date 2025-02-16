//
//  NavigationBar.swift
//  EDS_Store
//
//  Created by Илья Морозов on 15.02.2025.
//

import UIKit

extension UINavigationController {
    
    func setupNavBarAttrs() {
        let defAppear = UINavigationBarAppearance()
        
        defAppear.configureWithOpaqueBackground()
        
        defAppear.backgroundColor = .orange
        defAppear.titleTextAttributes = [.foregroundColor: UIColor.white]
        defAppear.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationBar.standardAppearance = defAppear
        self.navigationBar.scrollEdgeAppearance = defAppear
        self.navigationBar.compactAppearance = defAppear
        self.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        self.navigationBar.tintColor = .white
        
        
    }
}
