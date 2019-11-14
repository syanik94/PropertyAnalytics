//
//  MapPin.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/13/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit
import MapKit

class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(cityData: CityData) {
        self.coordinate = CLLocationCoordinate2D(latitude: cityData.coordinates.latitude, longitude: cityData.coordinates.longitude)
        self.title = cityData.description
        self.subtitle = "Predicted Price/sqft: $\(cityData.singleFamPredictedPricePerSqFt)"
        super.init()
    }
}
