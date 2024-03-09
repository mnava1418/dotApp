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
            TextInputView(text: $user.email, label: "Email", keyboardType: .emailAddress)
            
            PasswordInputView(password: $user.password, label: "Password")
                .padding(.top)
        }
    }
}

#Preview {
    LoginFormView(user: User(email: "email@test.com", password: "test"))
}
