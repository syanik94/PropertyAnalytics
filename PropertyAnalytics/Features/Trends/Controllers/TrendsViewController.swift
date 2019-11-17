//
//  TrendsViewController.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/14/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class TrendsViewController: UIViewController {
    
    private struct Constants {
        static let trendsCell = "trendsCell"
        static let loadingCell = "loadingCell"
    }
    
    // MARK: - Dependencies
    
    lazy var viewModel: TrendsViewModel = {
        let vm = TrendsViewModel()
        return vm
    }()
    
    // MARK: - Views
    
    fileprivate lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.dataSource = self
        tv.delegate = self
        tv.register(StateTrendTableViewCell.self,
                    forCellReuseIdentifier: Constants.trendsCell)
        tv.register(LoadingTableViewCell.self,
                    forCellReuseIdentifier: Constants.loadingCell)
        return tv
    }()
    
    fileprivate lazy var dismissButton: CancelButton = {
        let v = CancelButton()
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        return v
    }()
    
    // MARK: - Initializer Methods
    
    init(stateTrend: String) {
        super.init(nibName: nil, bundle: nil)
        viewModel.getTrends(for: stateTrend)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        setupTableView()
        setupNavBar()
    }
    
    // MARK: - Binding
    
    fileprivate func bindToViewModel() {
        viewModel.stateChanges = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - View Setup
    
    fileprivate func setupTableView() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.anchor(
            top: view.layoutMarginsGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.layoutMarginsGuide.bottomAnchor,
            trailing: view.trailingAnchor)
    }
    
    // MARK: - View Setup
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Market Trends"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dismissButton)
    }
    
    // MARK: - Actions
    
    @objc fileprivate func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension TrendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stateTrendsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.trendsCell, for: indexPath) as? StateTrendTableViewCell else { return UITableViewCell() }
            cell.stateTrendViewModel = viewModel.stateTrendsViewModels[indexPath.row]
            return cell
    }
}

extension TrendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }

}
