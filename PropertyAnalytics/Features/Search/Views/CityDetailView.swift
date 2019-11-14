//
//  CityDetailView.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/13/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class CityDetailView: UIView {
    override var intrinsicContentSize: CGSize {
        return CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height / 5
        )
    }
    
    private let topBarView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.93, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    /// City
    private let cityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "City:"
        label.textAlignment = .left
        return label
    }()
    
    let cityDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Insert City"
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
        label.text = "Insert County"
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
        label.text = "Insert County"
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
    
    lazy var cancelButton: CancelButton = {
        let b = CancelButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(remove)))
        return b
    }()
    
    lazy var likeButton: SaveButton = {
        let b = SaveButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    lazy var contentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [cityContentStackView, countyContentStackView, predictedPriceContentStackView])
        sv.spacing = 3
        sv.distribution = .fill
        sv.axis = .vertical
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.masksToBounds = true
        addSubview(topBarView)
        topBarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topBarView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topBarView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topBarView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        topBarView.addSubview(cancelButton)
        cancelButton.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        addSubview(contentStackView)
        contentStackView.anchor(
            top: cancelButton.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        topBarView.addSubview(likeButton)
        likeButton.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 12)
    }
    
    @objc private func remove() {
        self.removeFromSuperview()
    }
}

