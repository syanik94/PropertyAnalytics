//
//  LoginService.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/12/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

protocol LoginProtocol {
    var loginHandler: (((User?), Error?) -> Void)? { get set }
    func login(email: String, password: String)
}

class LoginService: LoginProtocol {
    var loginHandler: (((User?), Error?) -> Void)?
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.loginHandler?(nil, error)
            }
            if let authResult = authResult {
                let signedinUser = User(uuid: authResult.user.uid, email: authResult.user.email ?? "")
                strongSelf.loginHandler?(signedinUser, nil)
            }
        }
    }
}
