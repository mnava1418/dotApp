//
//  RegisterCodeView.swift
//  DOT
//
//  Created by Martin Nava on 18/04/24.
//

import SwiftUI

struct RegisterCodeView: View {
    @ObservedObject public var user: DotUser
    @StateObject private var modal = Modal()
    
    @State private var showStepTwo = true
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.AppColors.darkMain, Color.AppColors.main]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ScrollView {
                VStack {
                    HStack {
                        Text("Hola, ¡empecemos tu registro!")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.AppColors.text)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Paso 1: ")
                            .bold()
                            .foregroundColor(Color.AppColors.text) +
                        Text("Solicita tu código de registro. Tras aprobar tu solicitud, te enviaremos un código para que puedas proceder.")
                            .foregroundColor(Color.AppColors.text)
                        Spacer()
                    }
                    .padding()
                    
                    TextInputView(text: $user.email, label: "Email", keyboardType: .emailAddress)
                        .padding()
                    
                    CustomButtonView(label: "Solicitar tu código", type: .primary) {
                        showStepTwo = false
                        user.requestCode { result, message in
                            AppStatus.shared.isProcessing = false
                            showStepTwo = true
                            modal.setModal(_title: result ? "Ok" : "Error", _text: message, _btnLabel: "Cerrar")
                        }
                    }
                    .padding()
                    
                    if(showStepTwo) {
                        HStack {
                            Spacer()
                            Text("¿Ya tienes tu código?")
                                .font(.title2)
                                .foregroundColor(Color.AppColors.text)
                            Spacer()
                        }
                        .padding()
                        .padding(.top)
                        .padding(.top)
                        
                         NavigationLink(destination: ProvideRegistrationCodeView(user: user)) {
                             NavigationLinkButton(label: "Continuar", type: .primary)
                                 .padding()
                         }
                         
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
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
    RegisterCodeView(user: DotUser())
}
