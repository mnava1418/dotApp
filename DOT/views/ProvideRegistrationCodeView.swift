//
//  ProvideRegistrationCodeView.swift
//  DOT
//
//  Created by Martin Nava on 28/05/24.
//

import SwiftUI

struct ProvideRegistrationCodeView: View {
    @ObservedObject public var user: DotUser
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.AppColors.darkMain, Color.AppColors.main]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ScrollView {
                VStack {
                    HStack {
                        Text("Código de registro")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.AppColors.text)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Paso 2: ")
                            .bold()
                            .foregroundColor(Color.AppColors.text) +
                        Text("Proporciona el código de registro que recibiste por correo electrónico.")
                            .foregroundColor(Color.AppColors.text)
                        Spacer()
                    }
                    .padding()
                    
                    TextEditorView(text: $user.registrationCode, keyboardType: .default)
                        .padding()
                    
                    NavigationLink(destination: RegisterFormView(user: user)) {
                        NavigationLinkButton(label: "Continuar", type: .primary)
                            .padding()
                     }
                }
                .navigationBarTitle("", displayMode: .inline)
            }
        }
    }
}

#Preview {
    ProvideRegistrationCodeView(user: DotUser())
}
