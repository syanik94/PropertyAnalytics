//
//  DetailAnnotationView.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/12/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit
import MapKit

class DetailAnnotationView: MKMarkerAnnotationView {
    
    private let city: UILabel = {
        let l = UILabel()
        l.text = "City"
        return l
    }()
    
    let cityLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .right
        l.text = "Insert City"
        return l
    }()
    
    private lazy var cityStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [city, cityLabel])
        sv.spacing = 5
        sv.distribution = .fillEqually
        return sv
    }()
    
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        addSubview(cityStackView)
        cityStackView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
