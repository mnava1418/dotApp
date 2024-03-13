//
//  RegisterFormView.swift
//  DOT
//
//  Created by Martin Nava on 09/03/24.
//

import SwiftUI

struct RegisterFormView: View {
    @ObservedObject public var user: User
    @ObservedObject public var modal: Modal
    @Binding public var inLoginMode: Bool
    
    var body: some View {
        VStack {
            TextInputView(text: $user.name, label: "Nombre", keyboardType: .default)
            
            TextInputView(text: $user.email, label: "Email", keyboardType: .emailAddress)
                .padding(.top)
            
            PasswordInputView(password: $user.password, label: "Password")
                .padding(.top)
            
            PasswordInputView(password: $user.confirmPassword, label: "Confirma tu password")
                .padding(.top)
            
            CustomButtonView(label: "Regístrate", type: .primary) {
                user.register { (result, message) in
                    AppStatus.shared.isProcessing = false
                    
                    modal.setModal(_title: result ? "Ok" : "Error", _text: message, _btnLabel: result ? "Cerrar" : "Reintentar")
                    
                    if(result) {
                        inLoginMode.toggle()
                    }
                }
            }
            .padding(.top, 40)
            
            Button {
                inLoginMode.toggle()
            } label: {
                Text("Ya tienes cuenta? Login")
                    .font(.title2)
                    .foregroundColor(Color.AppColors.text)
            }
            .padding(.top)
        }
    }
}

#Preview {
    RegisterFormView(user: User(), modal: Modal(), inLoginMode: .constant(false))
}
