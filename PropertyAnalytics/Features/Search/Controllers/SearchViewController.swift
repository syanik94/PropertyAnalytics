//
//  SearchViewController.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/12/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {
    
    private struct Constants {
        static let mapID = "mapCall"
        static let searchID = "searchCell"
        static let loadingID = "loadingCell"
    }
    
    // MARK: - Dependencies
    
    let viewModel = SearchViewModel()
    let cityDetailViewPresenter = CityDetailViewPresenter()
    
    // MARK: - Views
        
    lazy var citySearchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Search City"
        sc.searchBar.searchBarStyle = .minimal
        sc.obscuresBackgroundDuringPresentation = false
        sc.hidesNavigationBarDuringPresentation = false
        sc.searchBar.delegate = self
        sc.delegate = self
        return sc
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    // MARK: - Initializer Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableViewSetup()
        bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    // MARK: - Binding
    
    fileprivate func bindToViewModel() {
        viewModel.handleUpdates = { [weak self] in
            guard let self = self else { return }
            switch self.viewModel.state {
                
            case .showMap:
                break
                
            case .searching:
                self.cityDetailViewPresenter.remove()
                
            case .empty:
                break
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - View Setup
    
    fileprivate func tableViewSetup() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MapTableViewCell.self, forCellReuseIdentifier: Constants.mapID)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.searchID)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: Constants.loadingID)
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Search"
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.searchController = citySearchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogoutTap))
    }
    
    // MARK: - Action
    
    @objc fileprivate func handleLogoutTap() {
        self.dismiss(animated: true, completion: nil)
        // TODO - HANDLE SIGN OUT
        /*
             let firebaseAuth = Auth.auth()
         do {
           try firebaseAuth.signOut()
         } catch let signOutError as NSError {
           print ("Error signing out: %@", signOutError)
         }
         */
    }
    
}

// MARK: - TableView Datasource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.state {
            
        case .showMap, .empty:
            tableView.separatorStyle = .none
            return 1
            
        case .searching:
            tableView.separatorStyle = .singleLine
            return viewModel.citySearchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.state {
            
        case .showMap:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.mapID, for: indexPath) as? MapTableViewCell else { return UITableViewCell() }
            cell.mapView.delegate = self
            return cell
            
        case .searching:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchID, for: indexPath)
            cell.textLabel?.text = self.viewModel.citySearchResults[indexPath.item]
            return cell
            
        case .empty:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.loadingID, for: indexPath) as? LoadingTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
}

// MARK: - TableView Delegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.state {
            
        case .showMap, .empty:
            return tableView.frame.height
            
        case .searching:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - Search Delegate

extension SearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.handleShowMap()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.handleSearch(searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.handleSearch(searchBar.text ?? "")
    }
}

// MARK: - Map View Delegate

extension SearchViewController: MKMapViewDelegate {
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        let mapPins = viewModel.cityData.map { (cityData) -> MapPin in
            let pin = MapPin(cityData: cityData)
            return pin
        }
        mapView.addAnnotations(mapPins)
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotationCoordinate = view.annotation?.coordinate {
            print("User tapped on annotation with title: \(annotationCoordinate)")
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      guard let annotation = annotation as? MapPin else { return nil }
      let identifier = "marker"
      var view: MKMarkerAnnotationView
      if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        as? MKMarkerAnnotationView {
        dequeuedView.annotation = annotation
        view = dequeuedView
      } else {
        view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: 5)
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      }
      return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let key = (view.annotation?.title) ?? ""
        if let dictKey = key {
            let cityData = viewModel.cityDictionary[dictKey]
            print(cityData)
            cityDetailViewPresenter.present(in: self, with: cityData!)
            // TODO - Pass this to details VC
        }
        
    }
    
}


