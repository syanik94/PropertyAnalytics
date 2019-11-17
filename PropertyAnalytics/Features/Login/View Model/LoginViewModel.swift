//
//  LoginViewModel.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/12/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    // MARK: - Dependencies
    
    var loginService: LoginProtocol?

    // MARK: - State
    
    enum State {
        case awaiting
        case loggedIn(user: User)
        case failed(error: String)
    }
    
    private(set) var state: State = .awaiting {
        didSet {
            stateUpdated?()
        }
    }
    var stateUpdated: (() -> Void)?

    var email: String?
    var password: String?

    // MARK: - Initializer

    init(loginService: LoginProtocol = LoginService() ) {
        self.loginService = loginService
        
        self.loginService?.loginHandler = { [weak self] (user, error) in
            if let error = error { self?.state = .failed(error: error.localizedDescription) }
            if let user = user { self?.state = .loggedIn(user: user) }
        }
    }
    
    // MARK: - API
    
    func handleLogin() {
        loginService?.login(email: email ?? "", password: password ?? "")
    }
    

}



