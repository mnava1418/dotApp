//
//  HomeView.swift
//  DOT
//
//  Created by Martin Nava on 11/06/24.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State private var user:User? = nil
    @State private var userName = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.AppColors.darkMain, Color.AppColors.main]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                HStack {
                    Text("Hola \(userName),")
                        .font(.system(size: 40))
                        .bold()
                        .foregroundColor(Color.AppColors.text)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Spacer()
                
                VStack {
                    Button(action: {
                    }) {
                        Image("dot")
                         .resizable()
                         .frame(width: 200, height: 200)
                         .padding()
                    }
                 }
                
                Spacer()
            }
            .onAppear{
                user = Auth.auth().currentUser
                
                if let currUser = user, let displayName = currUser.displayName {
                    userName = displayName
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
