//
//  CityDetailContentView.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/16/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class CityDetailContentView: UIView {
    
    /// City
    private let cityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "City:"
        label.textAlignment = .left
        return label
    }()
    
    let cityDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "No Data"
        label.textAlignment = .right
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var cityContentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [cityTitleLabel, cityDescriptionLabel])
        sv.spacing = 4
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        return sv
    }()
    
    /// County
    private let countyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "County, State:"
        label.textAlignment = .left
        return label
    }()
    
    let countyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "No Data"
        label.textAlignment = .right
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var countyContentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [countyTitleLabel, countyDescriptionLabel])
        sv.spacing = 4
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        return sv
    }()
    
    /// Predicted Price
    private let predictedPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Predicted Price/sqft:"
        label.textAlignment = .left
        return label
    }()
    
    let predictedPriceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "No Data"
        label.textAlignment = .right
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var predictedPriceContentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [predictedPriceTitleLabel, predictedPriceDescriptionLabel])
        sv.spacing = 4
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        return sv
    }()
    
    // current price/sqft
    private let currentPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Price/sqft:"
        label.textAlignment = .left
        return label
    }()

    let currentPriceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "No Data"
        label.textAlignment = .right
        label.textColor = .darkGray
        return label
    }()

    private lazy var currentPriceContentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [currentPriceTitleLabel, currentPriceDescriptionLabel])
        sv.spacing = 4
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        return sv
    }()
    
    //
    lazy var contentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            cityContentStackView,
            countyContentStackView,
            predictedPriceContentStackView
            ,currentPriceContentStackView
        ])
        sv.axis = .vertical
        sv.spacing = 3
        sv.distribution = .fill
        return sv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentStackView)
        contentStackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}








