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
    let persistenceService = DataPersistenceService()
    let mappingDataLoader = MappingDataLoader()
    let favoritesDataLoader = SavedCityDataLoader()
        
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
    
    var citySearchResults: [String] = []

    private(set) var cityData: [CityData] = []
    private(set) var cityDictionary: [String: CityDataViewModel] = [:] /// cityData.description is used as the mapping key  see ln: 46
    
    var selectedCity: CityData?
    private var savedCities: [CityData] = []
    private(set) var cityDataViewModel: [CityDataViewModel] = []
    
    
    // MARK: - Initializer Methods
        
    init() {
        observeFavLoader()
        observeMapLoader()
        
        loadFavsData()
    }
    
    // MARK: - Observers
    
    fileprivate func observeMapLoader() {
        mappingDataLoader.mappingDataCompletion = { [weak self] (data, error) in
            guard let self = self else { return }
            if let error = error { print(error) }
            if let data = data {
                self.cityData = data
                self.didLoadMapData = true
            }
        }
    }
    
    fileprivate func observeFavLoader() {
        favoritesDataLoader.savedCityDataCompletion = { [weak self] (data, err) in
            guard let self = self else { return }
           if let err = err { print(err) }
           else {
            self.savedCities = data
            self.didLoadFavData = true
           }
       }
    }
    
    // MARK: -
    
    private var didLoadFavData = false {
        didSet {
            loadMapData()
        }
    }
    
    private var didLoadMapData = false {
        didSet {
            configureCityViewModel()
            setupDataDictionary()
            state = .showMap
        }
    }
    
    fileprivate func loadMapData() {
        mappingDataLoader.load()
    }
    
    fileprivate func loadFavsData() {
        favoritesDataLoader.load()
    }

    fileprivate func configureCityViewModel() {
        if savedCities.isEmpty {
            cityDataViewModel = cityData.map({ CityDataViewModel(cityData: $0, isSaved: false) })
        }
        if !savedCities.isEmpty {
            cityDataViewModel = cityData.map({ (city) -> CityDataViewModel in
                for savedCity in savedCities {
                  if savedCity.description == city.description {
                    return CityDataViewModel(cityData: city, isSaved: true)
                    }
                }
                
                for savedCity in savedCities {
                  if savedCity.description != city.description {
                    return CityDataViewModel(cityData: city, isSaved: false)
                    }
                }
                return CityDataViewModel(cityData: city, isSaved: false)
            })
        }
    }
    
    fileprivate func setupDataDictionary() {
        cityDataViewModel.forEach { (vm) in
            self.cityDictionary[vm.cityData.description] = vm
        }
    }
    
    // MARK: -
    
    func handleShowMap() {
        state = .showMap
    }
        
    func handleSearch(_ text: String) {
        citySearchResults = cityData.map({ $0.description }).filter({ (name) -> Bool in
            return name.contains(text)
        })
        state = .searching(searchText: text)
    }
    
    func save() {
        if let selectedCity = selectedCity {
            if savedCities.contains(where: { $0.docID == selectedCity.docID }) {
                savedCities = savedCities.filter({ $0.docID != selectedCity.docID })
            } else {
                savedCities.append(selectedCity)
            }
            didLoadMapData = true
            persistenceService.save(collection: .users, doc: (UserService.shared.user?.uuid)!,
                                    data: self.savedCities.map({ $0.docID })
            )
        }
    }
}
