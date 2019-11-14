//
//  SearchViewModel.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/12/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    // MARK: - Dependencies
    
    let mappingDataLoader = MappingDataLoader()
    
    // MARK: - State
    
    enum State {
        case empty
        case showMap
        case searching(searchText: String)
    }
    
    private(set) var state: State = .empty {
        didSet {
            handleUpdates?()
        }
    }
    var handleUpdates: (() -> Void)?

    private(set) var cityData: [CityData] = []
    var citySearchResults: [String] = []
    private(set) var cityDictionary: [String: CityData] = [:] /// cityData.description is used as the mapping key  see ln: 46
    
    // MARK: - Initializer Methods
        
    init() {
        mappingDataLoader.mappingDataCompletion = { [weak self] (data, error) in
            if let error = error { print(error) }
            if let data = data {
                self?.cityData = data
                data.forEach { (city) in
                    self?.cityDictionary[city.description] = city
                }
                self?.state = .showMap
            }
        }
        mappingDataLoader.load()
    }
    
    func handleShowMap() {
        state = .showMap
    }
    
    func handleSearch(_ text: String) {
        citySearchResults = cityData.map({ $0.description }).filter({ (name) -> Bool in
            return name.contains(text)
        })
        state = .searching(searchText: text)
    }
}
