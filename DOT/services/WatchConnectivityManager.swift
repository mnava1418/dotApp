//
//  WatchConnectivityManager.swift
//  DOT
//
//  Created by Martin Nava on 14/06/24.
//

import Foundation
import WatchConnectivity
import FirebaseAuth

class WatchConnectivityManager: NSObject, WCSessionDelegate {
    static let shared = WatchConnectivityManager()
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func sendMessage(message: [String: Any]) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Error sending message: \(error.localizedDescription)")
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
            replyHandler(prepareResponse(message: message))
    }
    
    private func prepareResponse(message: [String: Any]) -> [String: Any] {
        if message["request"] as? String == "authStatus" {
            let authStatus = AuthService.getAuthStatus()
            return authStatus
        }
        return [:]
    }
    
    // WCSessionDelegate methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
}
