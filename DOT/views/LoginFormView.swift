//
//  LoginFormView.swift
//  DOT
//
//  Created by Martin Nava on 08/03/24.
//

import SwiftUI

struct LoginFormView: View {
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
                            user.login() { (result, errorMessage) in
                                AppStatus.shared.isProcessing = false
                                
                                if(result && AuthStatus.shared.isEmailVerified) {
                                    return
                                }
                                
                                var modalText = "Usuario y/o Password incorrecto."
                                var modalLabel = "Reintentar"
                                
                                if let errorMessage = errorMessage {
                                    modalText = errorMessage
                                } else if(AuthStatus.shared.isUserAuthenticated && !AuthStatus.shared.isEmailVerified) {
                                    modalText = "Tu email no ha sido verificado."
                                    modalLabel = "Reenviar"
                                } else if(AuthStatus.shared.isUserAuthenticated && !AuthStatus.shared.isAccountActive) {
                                    modalText = "Tu cuenta no ha sido activada. Estamos procesando tu solicitud."
                                    modalLabel = "Ok"
                                }
                                
                                modal.setModal(_title: "Error", _text: modalText, _btnLabel: modalLabel)
                            }
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
            
            if(modal.show) {
                ModalView(onAction: {
                    if(AuthStatus.shared.isUserAuthenticated && !AuthStatus.shared.isEmailVerified) {
                        print("Vamos a reenviar el correo")
                    }
                    
                    modal.show = false
                    
                }, title: modal.title, message: modal.text, btnLabel: modal.btnLabel, align: .bottom, modal: modal)
            }
        }
    }
}

#Preview {
    LoginFormView(user: DotUser())
}
