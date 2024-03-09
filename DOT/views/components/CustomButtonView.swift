//
//  SecondaryBtnView.swift
//  DOT
//
//  Created by Martin Nava on 09/03/24.
//

import SwiftUI

struct CustomButtonView: View {
    public let label: String
    public let type: BtnType
    public let onClick: () -> Void
    
    var body: some View {
        Button {
            onClick()
        } label: {
            HStack {
                Spacer()
                Text(self.label)
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.AppColors.text)
                    .padding()
                Spacer()
            }
            .background(type.color)
            .cornerRadius(20.0)
        }
    }
}

#Preview {
    CustomButtonView(label: "Button", type: .primary) {
        print("On click")
    }
}
