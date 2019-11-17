//
//  TrendsViewModel.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/14/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class TrendsViewModel {
    
    // MARK: - Dependencies
    let trendDataLoader = TrendDataLoader()

    
    // MARK: - State
    
    var stateTrendsViewModels: [StateTrendViewModel] = []
    
    var isLoading = false {
        didSet {
            stateChanges?()
        }
    }
    var stateChanges: (() -> Void)?
    
    
    init() {
        listenForTrendUpdates()
    }
    
    fileprivate func listenForTrendUpdates() {
        trendDataLoader.trendsDataCompletion = { [weak self] (stateTrendVMs, error) in
            if let error = error {
                print(error)
            } else {
                self?.stateTrendsViewModels = stateTrendVMs ?? []
                self?.isLoading = false
            }
        }
    }
    
    func getTrends(for state: String) {
        isLoading = true
        trendDataLoader.loadTrends(for: state)
    }
}




