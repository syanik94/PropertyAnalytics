//
//  MappingDataLoader.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/12/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import Foundation
import Firebase

struct DataPersistenceService {
    let fb = FirestoreService()
    
    func save(collection: FirestoreService.Collection, doc: String, data: Any) {
        let docRef = fb.db
            .collection(collection.rawValue)
            .document(doc)
        
        docRef.updateData(["savedCity": data]) { err in
            if let err = err {
                print("Error updating document: \(err.localizedDescription)")
            }
        }
    }
}


class MappingDataLoader: DataLoader {
    var mappingDataCompletion: (([CityData]?, Error?) -> Void)?

    let firestoreService = FirestoreService()
    
    func load() {
        firestoreService.fetch(from: .city) { (result) in
            switch result {
            case .success(let cityDictionaries):
                let fetchedCities = cityDictionaries as? [QueryDocumentSnapshot]
                var cities: [CityData] = []

                fetchedCities?.forEach({ (doc) in
                    let docData = doc.data()
                    cities.append(CityData(dictionary: docData, docID: doc.documentID))
                })
          
                self.mappingDataCompletion?(cities, nil)
                
            case .failure(let err):
                self.mappingDataCompletion?(nil, err)
            }
        }
    }
}


