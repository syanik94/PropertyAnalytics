//
//  CancelButton.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/13/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class CancelButton: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.72, alpha: 0.9)
        heightAnchor.constraint(equalToConstant: 26).isActive = true
        widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        let cancelImageView = UIImageView(image: #imageLiteral(resourceName: "icons8-delete-15").withRenderingMode(.alwaysOriginal))
        cancelImageView.backgroundColor = .clear
        
        addSubview(cancelImageView)
        cancelImageView.anchor(
            top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor,
            padding: .init(top: 7, left: 7, bottom: 7, right: 7))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 13
        layer.masksToBounds = true
    }
}
