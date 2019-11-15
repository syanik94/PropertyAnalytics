//
//  FavoriteViewModel.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/15/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import Foundation

class FavoriteViewModel {
    
    // MARK: - Dependencies
    
    var favoritesDataLoader: SavedCityDataLoader?
    
    // MARK: - State
    
    var savedCities: [CityData] = []
    
    var isLoading = false {
        didSet {
            handleUpdate?()
        }
    }
    
    var handleUpdate: (() -> ())?
    
    // MARK: - Initializer
    
    init() {
        favoritesDataLoader = SavedCityDataLoader()
        observeUpdates()
    }
    
    // MARK: - API
    
    fileprivate func observeUpdates() {
        favoritesDataLoader?.savedCityDataCompletion = { [weak self] (data, err) in
            if let err = err {
                print(err)
            } else {
                self?.savedCities = data
                self?.isLoading = false
            }
        }
    }
    
    func getFavorites() {
        isLoading = true
        favoritesDataLoader?.load()
    }
    
}

