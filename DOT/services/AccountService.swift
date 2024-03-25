//
//  AccountService.swift
//  DOT
//
//  Created by Martin Nava on 17/03/24.
//

import Foundation
import FirebaseDatabase

struct AccountService {
    public static func createAccount(uid: String, name: String, email: String, completion: @escaping ((any Error)?) -> Void) {
        let ref = Database.database().reference()
        ref.child("users").child(uid).setValue([
            "email": email,
            "name": name,
            "isActive": false,
        ]) { error, _ in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    public static func isAccountActive(uid: String) {
        let ref = Database.database().reference()
        ref.child("users").child(uid).child("isActive").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? Bool else {
                AuthStatus.shared.isAccountActive = false
                return
            }
            AuthStatus.shared.isAccountActive = value
        }) { error in
            AuthStatus.shared.isAccountActive = false
        }
    }
}
