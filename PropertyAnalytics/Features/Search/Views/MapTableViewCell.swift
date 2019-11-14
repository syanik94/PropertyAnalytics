//
//  MapTableViewCell.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/12/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {
    
    let mapView: MKMapView = MKMapView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupMapView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupMapView() {
        addSubview(mapView)
        mapView.anchor(
            top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
}
