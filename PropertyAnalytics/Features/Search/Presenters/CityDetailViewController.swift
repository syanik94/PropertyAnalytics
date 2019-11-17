//
//  CityDetailViewController.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/13/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

struct CityDetailViewPresenter {
    var viewController: SearchViewController?
    let cityDetailView = CityDetailView()
    
    func remove() {
        cityDetailView.removeFromSuperview()
    }
    
    func present(with cityDataViewModel: CityDataViewModel) {
        cityDetailView.saveButton.addTarget(viewController, action: #selector(viewController?.handleSave), for: .touchUpInside)
        cityDetailView.trendsTap = { [weak viewController] in
            viewController?.handleTrendsTap()
        }
        
        cityDetailView.cityDetailContentView.cityDescriptionLabel.text = cityDataViewModel.cityData.description
        cityDetailView.cityDetailContentView.countyDescriptionLabel.text = cityDataViewModel.cityData.county +
                                                                            ", \(cityDataViewModel.cityData.state)"
        cityDetailView.cityDetailContentView.predictedPriceDescriptionLabel.text = "$\(cityDataViewModel.cityData.singleFamPredictedPricePerSqFt)"
        cityDetailView.saveButton.isSelected = cityDataViewModel.isSaved
        
        if let vc = viewController {
            vc.view.addSubview(cityDetailView)
            cityDetailView.translatesAutoresizingMaskIntoConstraints = false
            cityDetailView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
            cityDetailView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
            cityDetailView.bottomAnchor.constraint(equalTo: vc.view.layoutMarginsGuide.bottomAnchor).isActive = true
            cityDetailView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 5).isActive = true
        }
    }
}

