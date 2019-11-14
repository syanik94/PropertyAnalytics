//
//  CustomTextfield.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/12/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class CustomTextfield: UITextField {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 40)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = intrinsicContentSize.height / 2
    }
    
}
