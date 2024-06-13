//
//  SettingsView.swift
//  DOT
//
//  Created by Martin Nava on 11/06/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Button {
            AuthService.signOut()
        }label: {
            Text("Sign Out")
        }
    }
}

#Preview {
    SettingsView()
}
