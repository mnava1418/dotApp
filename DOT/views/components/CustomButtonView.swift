//
//  SecondaryBtnView.swift
//  DOT
//
//  Created by Martin Nava on 09/03/24.
//

import SwiftUI

struct SecondaryBtnView: View {
    public let label: String
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
            .background(Color.AppColors.contrast)
            .cornerRadius(20.0)
        }
    }
}

#Preview {
    SecondaryBtnView(label: "Secondary Button") {
        print("btn action")
    }
}
