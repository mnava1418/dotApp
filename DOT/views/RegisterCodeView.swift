//
//  RegisterCodeView.swift
//  DOT
//
//  Created by Martin Nava on 18/04/24.
//

import SwiftUI

struct RegisterCodeView: View {
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
                    
                    CustomButtonView(label: "Solicitar tu código", type: .primary) {
                        modal.setModal(_title: "Ok", _text: "Hemos enviado tu solicitud. Una vez aprobada, recibirás un correo con instrucciones para continuar.", _btnLabel: "Cerrar")
                    }
                    .padding()
                    
                    HStack {
                        Spacer()
                        Text("¿Ya tienes tu código?")
                            .font(.title2)
                            .foregroundColor(Color.AppColors.text)
                        Spacer()
                    }
                    .padding()
                    
                    CustomButtonView(label: "Continuar", type: .primary) {
                        
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
    RegisterCodeView()
}
