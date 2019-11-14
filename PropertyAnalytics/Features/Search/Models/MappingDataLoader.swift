//
//  MappingDataLoader.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/12/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import Foundation
import Firebase

class MappingDataLoader: DataLoader {
    var mappingDataCompletion: (([CityData]?, Error?) -> Void)?

    let firestoreService = FirestoreService()
    
    func load() {
        firestoreService.fetch(from: .city) { (result) in
            switch result {
            case .success(let cityDictionaries):
                let fetchedCities = cityDictionaries as? [[String: Any]]
                var cities: [CityData] = []
                
                fetchedCities?.forEach({ (dictionary) in
                    cities.append(CityData(dictionary: dictionary))
                })
                self.mappingDataCompletion?(cities, nil)
                
            case .failure(let err):
                self.mappingDataCompletion?(nil, err)
            }
        }
    }
    
}


