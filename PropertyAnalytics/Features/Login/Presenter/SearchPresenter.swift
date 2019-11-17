//
//  SearchPresenter.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/12/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

struct AppPresenter: PresenterProtocol {
    
    func present(in vc: UIViewController) {
//        let trendsVC = TrendsViewController()
        let searchVC = SearchViewController()
        let favVC = FavoritesViewController()
        
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        favVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
//        trendsVC.tabBarItem = UITabBarItem(title: "Trends", image: #imageLiteral(resourceName: "icons8-combo-chart-25").withRenderingMode(.alwaysTemplate), tag: 2)
        
        searchVC.tabBarItem.title = "Search"
        favVC.tabBarItem.title = "Favorites"
        
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [
            UINavigationController(rootViewController: searchVC),
//            UINavigationController(rootViewController: trendsVC),
            UINavigationController(rootViewController: favVC)
        ]
        tabBarVC.modalPresentationStyle = .fullScreen
        vc.present(tabBarVC, animated: true, completion: nil)
    }
    
}






