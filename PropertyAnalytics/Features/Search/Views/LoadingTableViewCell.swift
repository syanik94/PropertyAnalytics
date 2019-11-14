//
//  LoadingTableViewCell.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/12/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    let loadingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Loading..."
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(loadingLabel)
        loadingLabel.centerInSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

