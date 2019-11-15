//
//  SignUpButton.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/12/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class SignInButton: UIButton {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 60)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentHorizontalAlignment = .left
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SigninButtonStack: UIStackView {
    
    let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let fbButton: UIButton = {
        let b = SignInButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setBackgroundImage(#imageLiteral(resourceName: "FB").withRenderingMode(.alwaysOriginal), for: .normal)
        b.backgroundColor = .clear
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.setTitle("Sign in with Facebook", for: .normal)
        return b
    }()
    
    let googleButton: UIButton = {
        let b = SignInButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .clear
        b.setBackgroundImage(#imageLiteral(resourceName: "Google").withRenderingMode(.alwaysOriginal), for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.setTitle("Sign in with Google", for: .normal)
        return b
    }()
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        distribution = .fillEqually
        axis = .vertical
        spacing = 16
        addArrangedSubview(signInLabel)
        addArrangedSubview(fbButton)
        addArrangedSubview(googleButton)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
