//
//  UIViewController+Extensions.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/11/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

// MARK: - Adding Child View Controller

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}


