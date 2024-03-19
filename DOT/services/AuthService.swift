//
//  AuthService.swift
//  DOT
//
//  Created by Martin Nava on 12/03/24.
//

import Foundation
import FirebaseAuth

struct AuthService {
    public static func createUser (email: String, password: String, name: String, completion: @escaping (User?, (any Error)?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let user = authResult?.user else {
                completion(nil, NSError(domain: "AuthService", code: 0, userInfo: [NSLocalizedDescriptionKey : "No auth result found"]))
                return
            }
            
            AccountService.createAccount(uid: user.uid, name: name, email: email) { accountError in
                if let accountError = accountError {
                    completion(nil, accountError)
                } else {
                    completion(user, nil)
                }
            }
        }
    }
}
