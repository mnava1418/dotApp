//
//  LoginFormView.swift
//  DOT
//
//  Created by Martin Nava on 08/03/24.
//

import SwiftUI

struct LoginFormView: View {
    @ObservedObject public var user: User
    
    var body: some View {
        VStack {
            Image("dot")
                .resizable()
                .frame(width: 150, height: 150)
                .padding()
            
            TextInputView(text: $user.email, label: "Email", keyboardType: .emailAddress)
            
            PasswordInputView(password: $user.password, label: "Password")
                .padding(.top)
            
            Button {
                user.login()
            } label: {
                PrimaryBtnView(label: "Login")
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    LoginFormView(user: User())
}
