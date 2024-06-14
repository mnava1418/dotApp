//
//  ContentView.swift
//  dotWatch Watch App
//
//  Created by Martin Nava on 13/06/24.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @StateObject private var conectivityDelegate: WatchConnectivityDelegate = WatchConnectivityDelegate.shared
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.AppColors.darkMain, Color.AppColors.main]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            if(conectivityDelegate.isAuthenticated) {
                VStack {
                    Button(action: {
                        // Acción del botón
                        print("Botón presionado")
                    }) {
                        Image("dot")
                         .resizable()
                         .frame(width: 100, height: 100)
                         .padding()
                    }
                    .frame(width: 100, height: 100)
                    
                    Text("Hola Martin")
                        .padding(.top, 8)
                }
                .padding()
            } else {
                HStack {
                    Text("Por favor, inicia sesión desde tu celular.")
                        .multilineTextAlignment(.center)
                }
            }
        }
        .onAppear {
            setupWatchConnectivity()
        }
    }
    
    private func setupWatchConnectivity() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = WatchConnectivityDelegate.shared
            session.activate()
        }
    }
}

class WatchConnectivityDelegate: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = WatchConnectivityDelegate()
    @Published var isAuthenticated = false
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let isAuthenticated = message["isAuthenticated"] as? Bool {
            DispatchQueue.main.async {
                self.isAuthenticated = isAuthenticated
            }
        }
    }
}

#Preview {
    ContentView()
}
