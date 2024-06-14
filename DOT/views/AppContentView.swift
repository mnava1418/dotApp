//
//  AppContentView.swift
//  DOT
//
//  Created by Martin Nava on 24/03/24.
//

import SwiftUI

struct AppContentView: View {
    @StateObject private var authStatus: AuthStatus = AuthStatus.shared
        
    var body: some View {
        if(authStatus.isUserAuthenticated && authStatus.isEmailVerified) {
            VStack {
                MainView()
            }
            .onAppear{
                sendMessageToWatch(isAuthenticated: true)
            }
        } else {
            VStack {
                AuthenticationView()
            }
            .onAppear{
                sendMessageToWatch(isAuthenticated: false)
            }
        }
    }
    
    private func sendMessageToWatch(isAuthenticated: Bool) {
        WatchConnectivityManager.shared.sendMessage(message: ["isAuthenticated": isAuthenticated])
    }
}

#Preview {
    AppContentView()
}
