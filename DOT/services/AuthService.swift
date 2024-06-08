//
//  AuthService.swift
//  DOT
//
//  Created by Martin Nava on 12/03/24.
//

import Foundation
import FirebaseAuth

struct AuthService {
    public static func signIn (email: String, password: String, completion: @escaping(Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                AuthStatus.shared.isUserAuthenticated = false
                completion(false)
                return
            }
            
            guard let user = authResult?.user else {
                AuthStatus.shared.isUserAuthenticated = false
                completion(false)
                return
            }
            
            user.reload()
            AuthStatus.shared.isUserAuthenticated = true
            AuthStatus.shared.isEmailVerified = user.isEmailVerified
            completion(true)
        }
    }
    
    public static func signOut () {
        try? Auth.auth().signOut()
        AuthStatus.shared.reset()
    }
    
    public static func sendVerificationEmail () {
        if let user = Auth.auth().currentUser {
            user.sendEmailVerification()
        }
    }
    
    public static func resetPassword (email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
