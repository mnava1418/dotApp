//
//  AppContentView.swift
//  DOT
//
//  Created by Martin Nava on 24/03/24.
//

import SwiftUI

struct AppContentView: View {
    private var authController: AuthController = AuthController()
    @StateObject private var authStatus: AuthStatus = AuthStatus.shared
        
    var body: some View {
        if(authStatus.isUserAuthenticated && authStatus.isEmailVerified) {
            MainView()
        } else {
            AuthenticationView()
        }
    }
}

#Preview {
    AppContentView()
}
