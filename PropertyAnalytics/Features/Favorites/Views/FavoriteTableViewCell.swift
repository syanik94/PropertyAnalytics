//
//  FavoriteTableViewCell.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/15/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    var savedCity: CityData? {
        didSet {
            if let savedCity = savedCity {
                cityDetailsContentView.cityDescriptionLabel.text = savedCity.description
                cityDetailsContentView.countyDescriptionLabel.text = "\(savedCity.county), \(savedCity.state)"
                cityDetailsContentView.predictedPriceDescriptionLabel.text = "$\(savedCity.singleFamPredictedPricePerSqFt)"
                cityDetailsContentView.currentPriceDescriptionLabel.text = "$\(savedCity.singleFamPricePerSqFt)"
            }
        }
    }
    
    lazy var cityDetailsContentView: CityDetailContentView = {
        let v = CityDetailContentView()
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: nil)
        selectionStyle = .none
        addSubview(cityDetailsContentView)
        cityDetailsContentView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 8, left: 16, bottom: 8, right: 16))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
}
