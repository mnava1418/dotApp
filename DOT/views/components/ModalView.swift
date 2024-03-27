//
//  ModalView.swift
//  DOT
//
//  Created by Martin Nava on 09/03/24.
//

import SwiftUI

struct ModalView: View {
    public let onAction: () -> Void
    public let title: String
    public let message: String
    public let btnLabel: String
    public let align: ModalAlign
    
    @ObservedObject var modal: Modal
    
    var body: some View {
        VStack {
            if(align == .bottom || align == .center) {
                Spacer()
            }
            
            VStack {
                Text(self.title)
                    .font(.title2)
                    .foregroundColor(Color.AppColors.text)
                    .padding()
                    .padding(.top)
                    .bold()
                
                Text(self.message)
                    .font(.title3)
                    .foregroundColor(Color.AppColors.text)
                    .padding(.bottom)
                    .padding(.horizontal)
                
                CustomButtonView(label: btnLabel, type: .secondary) {
                    onAction()
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color.AppColors.darkContrast)
            .cornerRadius(Constants.View.cornerRadius)
            .shadow(radius: 10)
            .padding()
            
            if(align == .top || align == .center) {
                Spacer()
            }
        }
        .background(
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                withAnimation {
                    modal.show = false
                }
            }
        )
    }
}

#Preview {
    ModalView(onAction: {
        print("Modal Action")
    }, title: "Modal Title", message: "Modal text", btnLabel: "Modal BTN", align: .bottom, modal: Modal())
}

