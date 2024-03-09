//
//  ContentView.swift
//  DOT
//
//  Created by Martin Nava on 06/03/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var user = User(email: "", password: "")
    
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
                        
                        Image("dot")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .padding()
                        
                        LoginFormView(user: user)
                        
                        Button {
                            user.login()
                        } label: {
                            PrimaryBtnView(label: "Login")
                        }
                        .padding(.top, 40)
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
