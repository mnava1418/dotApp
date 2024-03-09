//
//  RegisterFormView.swift
//  DOT
//
//  Created by Martin Nava on 09/03/24.
//

import SwiftUI

struct RegisterFormView: View {
    @ObservedObject public var user: User
    
    var body: some View {
        VStack {
            TextInputView(text: $user.name, label: "Nombre", keyboardType: .default)
            
            TextInputView(text: $user.email, label: "Email", keyboardType: .emailAddress)
                .padding(.top)
            
            PasswordInputView(password: $user.password, label: "Password")
                .padding(.top)
            
            PasswordInputView(password: $user.confirmPassword, label: "Confirma tu password")
                .padding(.top)
            
            Button {
                user.register()
            } label: {
                PrimaryBtnView(label: "Regístrate")
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    RegisterFormView(user: User())
}
