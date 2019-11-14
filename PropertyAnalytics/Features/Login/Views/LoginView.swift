//
//  LoginView.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/11/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class LoginView: UIView {
    var usernameTextField: UITextField = {
        let tf = CustomTextfield()
        tf.backgroundColor = UIColor(white: 0.92, alpha: 0.98)
        tf.placeholder = "Username"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var passwordTextField: UITextField = {
        let tf = CustomTextfield()
        tf.backgroundColor = UIColor(white: 0.92, alpha: 0.98)
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let loginButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("SIGN IN", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return b
    }()
    
    lazy var contentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, loginButton])
        sv.spacing = 16
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(contentStackView)
        contentStackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

