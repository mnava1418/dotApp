//
//  MainView.swift
//  DOT
//
//  Created by Martin Nava on 24/03/24.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    var body: some View {
        TabView {
            Group {
                HomeView()
                    .tabItem {
                        Image(systemName: "circle.circle.fill")
                        Text("Inicio")
                    }
                
                ChatView()
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("Chat")
                    }
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Ajustes")
                    }
            }
            .toolbarBackground(Color.AppColors.darkContrast, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .accentColor(Color.AppColors.text)
        
    }
}

#Preview {
    MainView()
}
