//
//  AppStatus.swift
//  DOT
//
//  Created by Martin Nava on 11/03/24.
//

import Foundation

class AppStatus: ObservableObject {
    @Published public var isProcessing: Bool = false
    
    static let shared = AppStatus()
    
    private init() {}
}
