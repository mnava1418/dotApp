//
//  WatchConnectivityDelegate.swift
//  dotWatch Watch App
//
//  Created by Martin Nava on 15/06/24.
//

import Foundation
import WatchConnectivity
import SwiftUI

class WatchConnectivityDelegate: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = WatchConnectivityDelegate()
    @Published var isAuthenticated: Bool = false
    @Published var displayName: String = ""
    public var retryTimer: Timer?
    
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
            self.retryTimer?.invalidate()
            WCSession.default.sendMessage(message, replyHandler: { response in
                self.processMessage(message: response)
            }) { error in
                print("Error sending message: \(error.localizedDescription)")
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        processMessage(message: message)
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        print("Watch session reachability did change to: \(session.isReachable)")
    }
    
    private func processMessage(message: [String: Any]) {
        if let isAuthenticated = message["isAuthenticated"] as? Bool {
            DispatchQueue.main.async {
                self.isAuthenticated = isAuthenticated
                
                if let displayName = message["displayName"] as? String {
                    self.displayName = displayName
                }
            }
        }
    }
    
    // WCSessionDelegate methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
}
