//
//  AuthService.swift
//  dotWatch Watch App
//
//  Created by Martin Nava on 15/06/24.
//

import Foundation

class AuthService {
    
    public func scheduleAuthStatusCheck() {
        WatchConnectivityDelegate.shared.retryTimer?.invalidate()
        WatchConnectivityDelegate.shared.retryTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkAuthStatus), userInfo: nil, repeats: true)
    }
    
    @objc func checkAuthStatus() {
        let message = ["request": "authStatus"]
        WatchConnectivityDelegate.shared.sendMessage(message: message)
    }
}
