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
    
    @StateObject private var appStatus = AppStatus.shared
    
    var body: some View {
        Button {
            if(!appStatus.isProcessing) {
                onClick()
            }
        } label: {
            HStack {
                Spacer()
                
                if(appStatus.isProcessing) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                       .scaleEffect(2)
                       .tint(Color.AppColors.text)
                       .padding()
                } else {
                    Text(self.label)
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.AppColors.text)
                        .padding()
                }
                
                Spacer()
            }
            .background(type.color)
            .cornerRadius(Constants.View.cornerRadius)
        }
    }
}

#Preview {
    CustomButtonView(label: "Button", type: .primary) {
        print("On click")
    }
}
