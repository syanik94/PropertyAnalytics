//
//  CityDetailViewController.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/13/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

struct CityDetailViewPresenter {
    
    let cityDetailView = CityDetailView()
    
    func remove() {
        cityDetailView.removeFromSuperview()
    }
    
    func present(in vc: UIViewController, with cityData: CityData) {
        cityDetailView.cityDescriptionLabel.text = cityData.description
        cityDetailView.countyDescriptionLabel.text = cityData.county + ", \(cityData.state)"
        cityDetailView.predictedPriceDescriptionLabel.text = "$\(cityData.singleFamPredictedPricePerSqFt)"
        
        vc.view.addSubview(cityDetailView)
        cityDetailView.translatesAutoresizingMaskIntoConstraints = false
        cityDetailView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
        cityDetailView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
        cityDetailView.bottomAnchor.constraint(equalTo: vc.view.layoutMarginsGuide.bottomAnchor).isActive = true
        cityDetailView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 5).isActive = true
    }
}

