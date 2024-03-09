//
//  User.swift
//  DOT
//
//  Created by Martin Nava on 08/03/24.
//

import Foundation

class User: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
        
    public func login () {
        print("Email: \(self.email), Password: \(self.password)")
    }
    
    public func register () {
        print("Name: \(self.name), Email: \(self.email), Password: \(self.password), Confirm Password: \(self.confirmPassword)")

    }
}
