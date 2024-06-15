//
//  AppObserverService.swift
//  dotWatch Watch App
//
//  Created by Martin Nava on 15/06/24.
//

import Foundation
import SwiftUI

class AppObserverService {
    private let autService: AuthService = AuthService()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: WKExtension.applicationWillEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: WKExtension.applicationDidBecomeActiveNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: WKExtension.applicationWillEnterForegroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: WKExtension.applicationDidBecomeActiveNotification, object: nil)
    }
    
    @objc func applicationWillEnterForeground() {
        autService.scheduleAuthStatusCheck()
    }
    
    @objc func applicationDidBecomeActive() {
        autService.scheduleAuthStatusCheck()
    }
}
