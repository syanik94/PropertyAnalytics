//
//  StateTrendTableViewCell.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/14/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class StateTrendTableViewCell: UITableViewCell {
    
    var stateTrendViewModel: StateTrendViewModel? {
        didSet {
            setDataPoints()
        }
    }
    
    private lazy var stateLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        l.textAlignment = .center
        return l
    }()
    
    private lazy var descriptionLabel: UILabel = {
       let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textAlignment = .center
        return l
    }()
    
    private let lineChart = TrendView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func setupViews() {
        addSubview(stateLabel)
        stateLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 8, left: 8, bottom: 0, right: 8)
        )
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 8, left: 8, bottom: 8, right: 8)
        )
        
        addSubview(lineChart)
        lineChart.anchor(
            top: stateLabel.bottomAnchor,
            leading: leadingAnchor,
            bottom: descriptionLabel.topAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 8, left: 8, bottom: 8, right: 8)
        )
    }
    
    fileprivate func setDataPoints() {
        if let stateTrendViewModel = stateTrendViewModel {
            let labels = stateTrendViewModel.dataPoints.map({ $0.date })
            let values = stateTrendViewModel.dataPoints.map({ $0.value })
            lineChart.generateLineData(dataPoints: labels, values: values)
            stateLabel.text = stateTrendViewModel.state
            
            descriptionLabel.text = "\(stateTrendViewModel.dataPoints.first?.date ?? "")" +
                " to " +
            "\(stateTrendViewModel.dataPoints.last?.date ?? "")"
        }
    }
    
}
