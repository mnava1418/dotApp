//
//  LoginFormView.swift
//  DOT
//
//  Created by Martin Nava on 08/03/24.
//

import SwiftUI

struct LoginFormView: View {
    @ObservedObject public var user: DotUser
    @Binding public var inLoginMode: Bool
    
    var body: some View {
        VStack {
            Image("dot")
                .resizable()
                .frame(width: 150, height: 150)
                .padding()
            
            TextInputView(text: $user.email, label: "Email", keyboardType: .emailAddress)
            
            PasswordInputView(password: $user.password, label: "Password")
                .padding(.top)
            
            
            CustomButtonView(label: "Login", type: .primary) {
                user.login()
            }
            .padding(.top, 40)
                        
            Button {
                inLoginMode.toggle()
            } label: {
                Text("No tienes cuenta? Regístrate")
                    .font(.title2)
                    .foregroundColor(Color.AppColors.text)
            }
            .padding(.top)
        }
    }
}

#Preview {
    LoginFormView(user: DotUser(), inLoginMode: .constant(true))
}
