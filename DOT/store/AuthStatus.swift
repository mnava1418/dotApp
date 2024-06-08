//
//  AuthStatus.swift
//  DOT
//
//  Created by Martin Nava on 24/03/24.
//

import Foundation

class AuthStatus: ObservableObject {
    @Published public var isUserAuthenticated: Bool = false
    @Published public var isEmailVerified: Bool = false
    
    static let shared = AuthStatus()
    
    private init() {}
    
    public func reset () {
        isUserAuthenticated = false
        isEmailVerified = false
    }
}
