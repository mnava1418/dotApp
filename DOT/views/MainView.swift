//
//  MainView.swift
//  DOT
//
//  Created by Martin Nava on 24/03/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        Button {
            AuthService.signOut()
        }label: {
            Text("Sign Out")
        }
    }
}

#Preview {
    MainView()
}
