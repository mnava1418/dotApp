//
//  AuthController.swift
//  DOT
//
//  Created by Martin Nava on 24/03/24.
//

import Foundation
import FirebaseAuth
import Combine

class AuthController {
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
       authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { (_, user) in
           guard let user = user else {
               AuthStatus.shared.isUserAuthenticated = false
               return
           }
           
           user.reload()
           AuthStatus.shared.isUserAuthenticated = true
           AuthStatus.shared.isEmailVerified = user.isEmailVerified
       }
    }

    deinit {
       if let authStateDidChangeListenerHandle = authStateDidChangeListenerHandle {
           Auth.auth().removeStateDidChangeListener(authStateDidChangeListenerHandle)
       }
    }
}
