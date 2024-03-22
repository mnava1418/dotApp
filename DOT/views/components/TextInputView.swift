//
//  TextInput.swift
//  DOT
//
//  Created by Martin Nava on 08/03/24.
//

import SwiftUI

struct TextInputView: View {
    @Binding public var text: String
    public let label: String
    public let keyboardType: UIKeyboardType
    
    var body: some View {
        VStack {
            HStack {
                Text(self.label)
                    .font(.title2)
                    .foregroundColor(Color.AppColors.text)
                Spacer()
            }
            
            TextField("", text: $text)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .autocorrectionDisabled()
                .keyboardType(self.keyboardType)
                .padding()
                .background(Color.AppColors.text)
                .cornerRadius(Constants.View.cornerRadius)
        }
    }
}

#Preview {
    TextInputView(text: .constant("my text"), label: "my label", keyboardType: .emailAddress)
}
