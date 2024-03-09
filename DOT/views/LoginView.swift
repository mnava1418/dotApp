//
//  ContentView.swift
//  DOT
//
//  Created by Martin Nava on 06/03/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var user = User()
    @State private var inLoginMode = true
    
    var body: some View {
        ZStack {
            Color.AppColors.darkMain
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Rectangle()
                    .fill(Color.AppColors.darkMain)
                    .frame(width: UIScreen.main.bounds.width, height: 60)
                
                ScrollView {
                    VStack {
                        TypingTextView(fullText: "Hola DOT...", textFont: .largeTitle, textColor: Color.AppColors.text)
                            .bold()
                        
                        if(inLoginMode) {
                            LoginFormView(user: user, inLoginMode: $inLoginMode)
                        } else {
                            RegisterFormView(user: user, inLoginMode: $inLoginMode)
                                .padding(.top, 40)
                        }
                    }
                    .padding()
                }
                .padding()
            }.edgesIgnoringSafeArea(.top)
            
        }
    }
}

#Preview {
    LoginView()
}
