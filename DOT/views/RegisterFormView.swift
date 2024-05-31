//
//  RegisterFormView.swift
//  DOT
//
//  Created by Martin Nava on 09/03/24.
//

import SwiftUI

struct RegisterFormView: View {
    @ObservedObject public var user: DotUser
    @StateObject private var modal: Modal = Modal()
    @State private var registrationResult = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.AppColors.darkMain, Color.AppColors.main]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ScrollView {
                VStack {
                    HStack {
                        Text("Completa tu registro")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.AppColors.text)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Paso 3: ")
                            .bold()
                            .foregroundColor(Color.AppColors.text) +
                        Text("Completa el formulario para terminar tu registro. El correo electrónico que usaremos será el que proporcionaste al solicitar tu código de registro.")
                            .foregroundColor(Color.AppColors.text)
                        Spacer()
                    }
                    .padding()
                    
                    VStack {
                        TextInputView(text: $user.name, label: "Nombre", keyboardType: .default)
                        
                        PasswordInputView(password: $user.password, label: "Password")
                            .padding(.top)
                        
                        PasswordInputView(password: $user.confirmPassword, label: "Confirma tu password")
                            .padding(.top)
                        
                        CustomButtonView(label: "Regístrate", type: .primary) {
                            user.register { (result, message) in
                                AppStatus.shared.isProcessing = false
                                registrationResult = result
                                
                                modal.setModal(_title: result ? "Ok" : "Error", _text: message, _btnLabel: result ? "Cerrar" : "Reintentar")
                            }
                        }
                        .padding(.top, 40)
                    }
                    .padding()
                }
                .navigationBarTitle("", displayMode: .inline)
            }
            
            if(modal.show) {
                ModalView(onAction: {
                    modal.show = false
                    
                    if(registrationResult) {
                        user.reset()
                    }
                    
                }, title: modal.title, message: modal.text, btnLabel: modal.btnLabel, align: .bottom, modal: modal)
            }
        }
    }
}

#Preview {
    RegisterFormView(user: DotUser())
}
