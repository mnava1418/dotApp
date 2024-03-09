//
//  PrimaryBtnView.swift
//  DOT
//
//  Created by Martin Nava on 08/03/24.
//

import SwiftUI

struct PrimaryBtnView: View {
    public let label: String
    
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
        .background(Color.AppColors.darkContrast)
        .cornerRadius(20.0)
    }
}

#Preview {
    PrimaryBtnView(label: "Click")
}
