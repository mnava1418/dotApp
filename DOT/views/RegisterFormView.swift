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
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.AppColors.darkMain, Color.AppColors.main]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ScrollView {
                VStack {
                    HStack {
                        Text("Hola, regístrate para comenzar.")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.AppColors.text)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
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
                }, title: modal.title, message: modal.text, btnLabel: modal.btnLabel, align: .bottom)
            }
        }
    }
}

#Preview {
    RegisterFormView(user: DotUser())
}
