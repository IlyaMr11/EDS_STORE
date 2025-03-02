//
//  CustomTabBar.swift
//  EDS_Store
//
//  Created by Илья Морозов on 28.02.2025.
//

import Foundation

import UIKit

class ConfigureTabBar {
    static func setupTabBar() {
        let appearance = UITabBarAppearance()
        
        // Настройка цвета фона
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white // Цвет фона
        
        // Настройка цвета иконок и текста
        appearance.stackedLayoutAppearance.normal.iconColor = .orange // Цвет иконок в нормальном состоянии
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.orange] // Цвет текста в нормальном состоянии
        
        appearance.stackedLayoutAppearance.selected.iconColor = .systemRed // Цвет иконок в выбранном состоянии
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemRed] // Цвет текста в выбранном состоянии
        
        // Применяем настройки к стандартному и скроллящемуся состоянию
        UITabBar.appearance().standardAppearance = appearance
        
        
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
