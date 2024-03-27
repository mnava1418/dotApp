//
//  ResetPasswordView.swift
//  DOT
//
//  Created by Martin Nava on 21/03/24.
//

import SwiftUI

struct ResetPasswordView: View {
    @ObservedObject public var user: DotUser
    @StateObject private var modal = Modal()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.AppColors.darkMain, Color.AppColors.main]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ScrollView {
                VStack {
                    HStack {
                        Text("¿Olvidaste tu contraseña?")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.AppColors.text)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Ingresa tu dirección de correo electrónico y te enviaremos un enlace para que puedas restablecer tu contraseña.")
                            .foregroundColor(Color.AppColors.text)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 1)
                    .padding(.bottom)
                    
                    VStack {
                        TextInputView(text: $user.email, label: "Email", keyboardType: .emailAddress)
                        
                        CustomButtonView(label: "Enviar", type: .primary) {
                            user.resetPassword() {(result, message) in
                                AppStatus.shared.isProcessing = false
                                
                                modal.setModal(_title: result ? "Ok" : "Error", _text: message, _btnLabel: result ? "Cerrar" : "Reintentar")
                            }
                        }
                        .padding(.top, 40)
                    }
                    .padding()
                }
            }
            
            if(modal.show) {
                ModalView(onAction: {
                    modal.show = false
                }, title: modal.title, message: modal.text, btnLabel: modal.btnLabel, align: .bottom, modal: modal)
            }
        }
    }
}

#Preview {
    ResetPasswordView(user: DotUser())
}
