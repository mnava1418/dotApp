//
//  AuthenticationView.swift
//  DOT
//
//  Created by Martin Nava on 06/03/24.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var user = DotUser()
    @StateObject private var modal = Modal()
    @State private var inLoginMode = true
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor(Color.AppColors.text)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.AppColors.text)]
                
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("fondo")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                                
                VStack {
                    TypingTextView(fullText: "Hola DOT...", textFont: .largeTitle, textColor: Color.AppColors.text)
                        .bold()
                    
                    Image("dot")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding()
                    
                    VStack {
                        NavigationLink(destination: LoginFormView(user: user)) {
                            NavigationLinkButton(label: "Login", type: .primary)
                                .padding()
                        }

                        NavigationLink(destination: RegisterFormView(user: user, modal: modal, inLoginMode: $inLoginMode)) {
                            NavigationLinkButton(label: "Regístrate", type: .primary)
                                .padding()
                        }
                    }
                    .frame(maxWidth: 350)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.5))
            }
            .navigationBarTitle("", displayMode: .inline)
        }
        .tint(Color.AppColors.text)
    }
}

#Preview {
    AuthenticationView()
}
