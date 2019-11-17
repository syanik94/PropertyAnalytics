//
//  CityDetailView.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/13/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class CityPopUpDetailView: UIView {
    override var intrinsicContentSize: CGSize {
        return CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height / 4
        )
    }
    
    private let topBarView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.99, alpha: 0.2)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var cityDetailContentView: CityDetailContentView = {
        let v = CityDetailContentView()
        return v
    }()
    
    fileprivate lazy var cancelButton: CancelButton = {
        let b = CancelButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(remove)))
        return b
    }()
    
    lazy var saveButton: SaveButton = {
        let b = SaveButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
        
    fileprivate lazy var seeTrendsButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Mortage Rates", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        b.addTarget(self, action: #selector(handleTrendsTap), for: .touchUpInside)
        return b
    }()
    
    @objc fileprivate func handleTrendsTap() {
        trendsTap?()
    }
    
    var trendsTap: (() -> ())?
    
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
        
        topBarView.addSubview(saveButton)
        saveButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        addSubview(cityDetailContentView)
        cityDetailContentView.anchor(
            top: cancelButton.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16))
                
        addSubview(seeTrendsButton)
        seeTrendsButton.anchor(
            top: cityDetailContentView.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor,
            padding: .init(top: 4, left: 0, bottom: 5, right: 8))
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

