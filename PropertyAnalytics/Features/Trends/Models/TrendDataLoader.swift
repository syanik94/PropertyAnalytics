//
//  TrendDataLoader.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/14/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import Foundation

class TrendDataLoader {
    
    var trendsDataCompletion: (([StateTrendViewModel]?, Error?) -> Void)?

    let firestoreService = FirestoreService()
    
    func loadTrends(for state: String) {
        let rootDocRef = firestoreService.db
            .collection(FirestoreService.Collection.trends.rawValue)
            .document(state)
        
        
        rootDocRef.getDocument { [weak self] (querySnapshot, err) in
            if let err = err {
                self?.trendsDataCompletion?(nil, err)
            }
            if let snapshot = querySnapshot {
                var trendsViewModels: [StateTrendViewModel] = []
                let diction = snapshot.data() as? [String: [String: Double]]
                if let diction = diction {
                    trendsViewModels.append(StateTrendViewModel(state: snapshot.documentID, dictionary: diction))
                    self?.trendsDataCompletion?(trendsViewModels, nil)
                } else {
                    self?.trendsDataCompletion?([], nil)
                }
            }
        }
    }
}
