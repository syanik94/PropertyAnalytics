//
//  FavoritesViewController.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/15/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private struct Constant {
        static let favoriteCell = "favoriteCell"
    }
    
    lazy var viewModel: FavoriteViewModel = {
        let vm = FavoriteViewModel()
        return vm
    }()
    
    // MARK: - Views
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(FavoriteTableViewCell.self,
                    forCellReuseIdentifier: Constant.favoriteCell)
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getFavorites()
        setupNavBar()
        setupTableView()
        bindToViewModel()
    }
    
    // MARK: - Binding
    
    fileprivate func bindToViewModel() {
        
    }
    
    // MARK: - Setup View
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: Constant.favoriteCell, for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        
        return favoriteCell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
}

