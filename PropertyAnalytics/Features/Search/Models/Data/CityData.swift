//
//  CityData.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/12/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import Foundation
import Firebase

class CityData {
    let coordinates: GeoPoint
    let county: String
    let description: String
    let inventorySingleFamily: Int
    let populationEstimate: Int
    let singleFamListPrice: Int
    let singleFamPredictedListPrice: Int
    let singleFamPredictedPricePerSqFt: Int
    let singleFamPricePerSqFt: Double
    let state: String
    let docID: String
    
    init(dictionary: [String: Any], docID: String) {
        coordinates = dictionary["coordinates"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
        county = dictionary["county"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        inventorySingleFamily  = dictionary["inventorySingleFamily"] as? Int ?? 0
        populationEstimate = dictionary["populationEstimate"] as? Int ?? 0
        singleFamListPrice = dictionary["singleFamListPrice"] as? Int ?? 0
        singleFamPredictedListPrice = dictionary["singleFamPredictedListPrice"] as? Int ?? 0
        singleFamPredictedPricePerSqFt = dictionary["singleFamPredictedPricePerSqFt"] as? Int ?? 0
        singleFamPricePerSqFt = dictionary["singleFamPricePerSqFt"] as? Double ?? 0
        state = dictionary["state"] as? String ?? ""
        self.docID = docID
    }
}

class CityDataViewModel: Equatable {
    var isSaved: Bool
    let cityData: CityData
    
    init(cityData: CityData, isSaved: Bool) {
        self.cityData = cityData
        self.isSaved = isSaved
    }
    
    static func == (lhs: CityDataViewModel, rhs: CityDataViewModel) -> Bool {
        if lhs.cityData.description == rhs.cityData.description { return true }
        else { return false}
    }
}


