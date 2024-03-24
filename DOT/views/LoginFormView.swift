//
//  LoginFormView.swift
//  DOT
//
//  Created by Martin Nava on 08/03/24.
//

import SwiftUI

struct LoginFormView: View {
    @ObservedObject public var user: DotUser
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.AppColors.darkMain, Color.AppColors.main]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ScrollView {
                VStack {
                    HStack {
                        Text("Bienvenido, que gusto verte de nuevo.")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.AppColors.text)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        TextInputView(text: $user.email, label: "Email", keyboardType: .emailAddress)
                        
                        PasswordInputView(password: $user.password, label: "Password")
                            .padding(.top)
                        
                        
                        CustomButtonView(label: "Login", type: .primary) {
                            user.login()
                        }
                        .padding(.top, 40)
                        
                        NavigationLink(destination: ResetPasswordView()) {
                            Text("¿Olvidaste tu contraseña?")
                                .font(.title2)
                                .foregroundColor(Color.AppColors.text)
                        }
                        .padding(.top)
                        
                    }
                    .padding()
                }
                .navigationBarTitle("", displayMode: .inline)
            }
        }
    }
}

#Preview {
    LoginFormView(user: DotUser())
}
