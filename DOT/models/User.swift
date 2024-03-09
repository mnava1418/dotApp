//
//  User.swift
//  DOT
//
//  Created by Martin Nava on 08/03/24.
//

import Foundation

class User: ObservableObject {
    @Published var email: String
    @Published var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    public func login () {
        print("Email: \(self.email), Password: \(self.password)")
    }
}
