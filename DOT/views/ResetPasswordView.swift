//
//  ResetPasswordView.swift
//  DOT
//
//  Created by Martin Nava on 21/03/24.
//

import SwiftUI

struct ResetPasswordView: View {
    @StateObject var user = DotUser()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.AppColors.darkMain, Color.AppColors.contrast]),
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
                    .padding(.top)
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
                            user.resetPassword()
                        }
                        .padding(.top, 40)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ResetPasswordView()
}
