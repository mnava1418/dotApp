//
//  TypingTextView.swift
//  DOT
//
//  Created by Martin Nava on 08/03/24.
//

import SwiftUI

struct TypingTextView: View {
    let fullText: String
    let textFont: Font
    let textColor: Color
    
    @State private var displayText: String = ""
    @State private var charIndex: Int = 0

    var body: some View {
        Text(displayText)
            .font(textFont)
            .foregroundColor(textColor)
            .onAppear {
                startTypingAnimation()
            }
            .padding()
    }
    
    private func startTypingAnimation() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if charIndex < fullText.count {
                let index = fullText.index(fullText.startIndex, offsetBy: charIndex)
                displayText.append(fullText[index])
                charIndex += 1
            } else {
                timer.invalidate()
            }
        }
        timer.fire()
    }
}

#Preview {
    TypingTextView(fullText: "test", textFont: .largeTitle, textColor: .red)
}
