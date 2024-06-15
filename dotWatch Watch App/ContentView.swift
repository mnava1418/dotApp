//
//  ContentView.swift
//  dotWatch Watch App
//
//  Created by Martin Nava on 13/06/24.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    private var appObserver: AppObserverService = AppObserverService() //Needed to add app observers (applicationWillEnterForeground, applicationDidBecomeActive, etc)
    @StateObject private var connectivityDelegate: WatchConnectivityDelegate = WatchConnectivityDelegate.shared
        
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.AppColors.darkMain, Color.AppColors.main]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            if(connectivityDelegate.isAuthenticated) {
                VStack {
                    Button(action: {
                    }) {
                        Image("dot")
                         .resizable()
                         .frame(width: 100, height: 100)
                         .padding()
                    }
                    .frame(width: 100, height: 100)
                    
                    Text("Hola Test")
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
    }
}

#Preview {
    ContentView()
}
