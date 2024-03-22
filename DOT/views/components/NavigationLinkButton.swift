//
//  NavigationLinkButton.swift
//  DOT
//
//  Created by Martin Nava on 21/03/24.
//

import SwiftUI

struct NavigationLinkButton: View {
    public let label: String
    public let type: BtnType
    
    var body: some View {
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
        .cornerRadius(Constants.View.cornerRadius)
    }
}

#Preview {
    NavigationLinkButton(label: "Test", type: .primary)
}
