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
    
    private let lineChart = TrendView()
    
    private lazy var descriptionLabel: UILabel = {
       let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textAlignment = .center
        return l
    }()
    
    private let detailDescriptionLabel1: UILabel = {
           let l = UILabel()
           l.textAlignment = .left
           l.text = "Loan Program:"
           return l
       }()
       
       private lazy var loanProgramLabel: UILabel = {
           let l = UILabel()
           l.textAlignment = .right
           l.textColor = .gray
            l.text = "30yr Fixed"
           return l
       }()
       
       private lazy var loanProgramStackView: UIStackView = {
           let sv = UIStackView(arrangedSubviews: [detailDescriptionLabel1, loanProgramLabel])
           sv.axis = .horizontal
           sv.spacing = 8
           sv.distribution = .fillEqually
           return sv
       }()
    
    private let detailDescriptionLabel2: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.text = "Location:"
        return l
    }()
    
    private lazy var stateLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .right
        l.textColor = .gray
        return l
    }()
    
    private lazy var stateStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [detailDescriptionLabel2, stateLabel])
        sv.axis = .horizontal
        sv.spacing = 8
        sv.distribution = .fillEqually
        return sv
    }()
    
    private lazy var detailStackView: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [loanProgramStackView, stateStackView])
       sv.axis = .vertical
       sv.spacing = 6
       sv.distribution = .fillEqually
       return sv
   }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func setupViews() {
        addSubview(lineChart)
        lineChart.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 8, left: 8, bottom: 8, right: 8),
            size: .init(width: 0, height: 300)
        )
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(
            top: lineChart.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 6, left: 8, bottom: 8, right: 8)
        )
        
        addSubview(detailStackView)
        detailStackView.anchor(
            top: descriptionLabel.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 15, left: 50, bottom: 0, right: 50))
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
