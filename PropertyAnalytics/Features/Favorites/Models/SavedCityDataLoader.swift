//
//  SavedCityDataLoader.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/15/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import Foundation

class SavedCityDataLoader: DataLoader {
    var savedCityDataCompletion: (([CityData], Error?) -> Void)?

    let firestore = FirestoreService()
    
    func load() {
        let docRef = firestore.db
            .collection(FirestoreService.Collection.users.rawValue)
            .document(UserService.shared.user!.uuid!)
        
        docRef.getDocument { [weak self] (snapshot, err) in
            if let err = err { self?.savedCityDataCompletion?([], err) }
            
            if let document = snapshot {
                let savedCityMap = document.data() as? [String: [String]]
                let savedCities = savedCityMap?.values.flatMap({ $0 })
                self?.getCityData(for: savedCities ?? [])
            }
        }
    }
    
    
    // MARK: - Helper
    
    private func getCityData(for cities: [String]) {
        var cityData = [CityData]()
        
        cities.forEach { (city) in
            let cityDocRef = firestore.db
                .collection(FirestoreService.Collection.city.rawValue)
                .document(city)
            
            cityDocRef.getDocument { [weak self] (snapshot, err) in
                if let err = err {
                    self?.savedCityDataCompletion?([], err)
                    return
                }

                if let document = snapshot {
                    if let documentMap = document.data() {
                        cityData.append(CityData(dictionary: documentMap))
                        self?.savedCityDataCompletion?(cityData, nil)
                    }
                }
            }
        }
    }
}
