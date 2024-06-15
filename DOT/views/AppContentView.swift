//
//  AppContentView.swift
//  DOT
//
//  Created by Martin Nava on 24/03/24.
//

import SwiftUI

struct AppContentView: View {
    private var authController: AuthController = AuthController() //to add authentication listener
    @StateObject private var authStatus: AuthStatus = AuthStatus.shared
    private var connectivityManager: WatchConnectivityManager = WatchConnectivityManager.shared
        
    var body: some View {
        if(authStatus.isUserAuthenticated && authStatus.isEmailVerified) {
            VStack {
                MainView()
            }
            .onAppear{
                connectivityManager.sendMessage(message: AuthService.getAuthStatus())
            }
        } else {
            VStack {
                AuthenticationView()
            }
            .onAppear{
                connectivityManager.sendMessage(message: AuthService.getAuthStatus())
            }
        }
    }
}

#Preview {
    AppContentView()
}
