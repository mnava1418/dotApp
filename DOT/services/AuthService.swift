//
//  AuthService.swift
//  DOT
//
//  Created by Martin Nava on 12/03/24.
//

import Foundation
import FirebaseAuth

struct AuthService {
    public static func createUser (email: String, password: String, name: String, completion: @escaping ((any Error)?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(error)
            } else if let authResult = authResult {
                authResult.user.sendEmailVerification { emailError in
                    if let emailError = emailError {
                        self.logOut()
                        completion(emailError)
                    } else {
                        AccountService.createAccount(uid: authResult.user.uid, name: name, email: email) { accountError in
                            self.logOut()
                            
                            if let accountError = accountError {
                                completion(accountError)
                            } else {
                                
                                completion(nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    public static func logOut () {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error: %@", signOutError)
        }
    }
}
