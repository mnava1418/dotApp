//
//  PasswordInput.swift
//  DOT
//
//  Created by Martin Nava on 08/03/24.
//

import SwiftUI

struct PasswordInputView: View {
    @Binding public var password: String
    public let label: String
    
    var body: some View {
        VStack {
            HStack {
                Text(self.label)
                    .font(.title2)
                    .foregroundColor(Color.AppColors.text)
                Spacer()
            }
            
            SecureField("", text: $password)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .autocorrectionDisabled()
                .padding()
                .background(Color.AppColors.text)
                .cornerRadius(20.0)
        }
    }
}

#Preview {
    PasswordInputView(password: .constant("myPassword"), label: "Password")
}
