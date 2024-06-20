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
    @StateObject private var audioService: AudioService = AudioService()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.AppColors.darkMain, Color.AppColors.main]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                HStack {
                    Text("Hola \(userName), ¿cómo puedo ayudarte?")
                        .font(.system(size: 30))
                        .bold()
                        .foregroundColor(Color.AppColors.text)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 20)
                                
                VStack {
                    Button(action: {
                        audioService.isRecording ? audioService.stopRecording(message: "Tu solicitud ha sido cancelada.") : audioService.startRecording()
                    }) {
                        Image("dot")
                         .resizable()
                         .frame(width: 200, height: 200)
                         .padding()
                    }
                    
                    HStack {
                        Text(audioService.transcription)
                            .padding()
                            .background(Color.AppColors.darkContrast)
                            .foregroundColor(Color.AppColors.text)
                            .cornerRadius(10)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 40)
                 }
                .padding(.top, 100)
                
                Spacer()
            }
            .onAppear{
                user = Auth.auth().currentUser
                
                if let currUser = user, let displayName = currUser.displayName {
                    userName = displayName
                }
                
                self.requestAuthorization()
            }
        }
    }
    
    private func requestAuthorization() {
        DeviceAuthService.requestSpeechRecognition { speechResult in
            if(speechResult) {
                DeviceAuthService.requestMicrophone{ micResult in
                    audioService.deviceAuthorized = micResult
                }
            }
        }
    }    
}

#Preview {
    HomeView()
}
