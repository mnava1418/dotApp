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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.AppColors.darkMain, Color.AppColors.contrast]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.AppColors.darkMain, Color.AppColors.contrast]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                    VStack {
                        TypingTextView(fullText: "Hola DOT...", textFont: .largeTitle, textColor: Color.AppColors.text)
                            .bold()
                        
                        Image("dot")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .padding()
                        
                        NavigationLink(destination: LoginFormView(user: user)) {
                            NavigationLinkButton(label: "Login", type: .primary)
                                .padding()
                        }
                        
                        NavigationLink(destination: RegisterFormView(user: user, modal: modal, inLoginMode: $inLoginMode)) {
                            NavigationLinkButton(label: "Regístrate", type: .primary)
                                .padding()
                        }
                    }
                    .navigationBarTitle("", displayMode: .inline)
                }
            }
            .tint(Color.AppColors.text)
            .padding(.horizontal)
        }
    }
}

#Preview {
    AuthenticationView()
}
