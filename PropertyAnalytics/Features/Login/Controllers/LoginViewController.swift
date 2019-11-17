//
//  ContentView.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/11/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
     
    // MARK: - Dependencies
    
    let viewModel: LoginViewModel = LoginViewModel()
    lazy var presenter: PresenterProtocol? = {
        let presenter = AppPresenter()
        return presenter
    }()
 
    // MARK: - Views
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "property").withRenderingMode(.alwaysOriginal))
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        label.text = "Property\nAnalytics"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var loginView: LoginView = {
        let v = LoginView(frame: .zero)
        v.usernameTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        v.passwordTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        v.loginButton.addTarget(self, action: #selector(handleSignInTap), for: .touchUpInside)
        return v
    }()
    
    lazy var signinButtonStack: SigninButtonStack = {
        let sv = SigninButtonStack(frame: .zero)
        sv.fbButton.addTarget(self, action: #selector(handleQuickSignInTap), for: .touchUpInside)
        sv.googleButton.addTarget(self, action: #selector(handleQuickSignInTap), for: .touchUpInside)
        return sv
    }()
    
    // MARK: - Initializer Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBackground()
        setupViews()
        setupButtonViews()
        bindToViewModel()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    @objc fileprivate func endEditing() {
        view.endEditing(false)
    }
    
    // MARK: - Bindings
    
    fileprivate func bindToViewModel() {
        viewModel.stateUpdated = { [weak self] in
            guard let self = self else { return }
            switch self.viewModel.state {
                
            case .failed(let errorDescription):
                self.handleError(message: errorDescription)
                
            case .loggedIn(let user):
                self.handleSuccess(user)
            default: break
            }
        }
    }
    
    fileprivate func handleError(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    fileprivate func handleSuccess(_ user: User) {
        self.presenter?.present(in: self)
    }
    
    // MARK: - View Setup
    
    fileprivate func setupBackground() {
        view.addSubview(backgroundImage)
        backgroundImage.fillSuperview()
    }
    
    fileprivate func setupViews() {
        let headerHeight = view.frame.height / 6
        view.addSubview(headerLabel)
        headerLabel.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: headerHeight, left: 24, bottom: 0, right: 24))
        
        view.addSubview(loginView)
        loginView.anchor(
            top: headerLabel.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 20, left: 32, bottom: 0, right: 32))
    }
    
    fileprivate func setupButtonViews() {
        view.addSubview(signinButtonStack)
        signinButtonStack.anchor(
            top: loginView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 20, left: 64, bottom: 0, right: 64))
    }
    
    
    // MARK: - Sign in
    
    @objc fileprivate func handleTextFieldChange(textField: UITextField) {
        if textField == self.loginView.passwordTextField { viewModel.password = textField.text ?? "" }
        if textField == self.loginView.usernameTextField { viewModel.email = textField.text ?? "" }
    }
    
    @objc func handleSignInTap() {
        viewModel.handleLogin()
    }

    @objc fileprivate func handleQuickSignInTap() {
        viewModel.password = "Test123!"
        viewModel.email = "test@test.com"
        
        loginView.usernameTextField.text = "test@test.com"
        loginView.passwordTextField.text = "Test123!"
        
        viewModel.handleLogin()
    }
    
}

