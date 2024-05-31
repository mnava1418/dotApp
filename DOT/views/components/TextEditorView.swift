//
//  TextEditorView.swift
//  DOT
//
//  Created by Martin Nava on 30/05/24.
//

import SwiftUI

struct CustomTextEditor: UIViewRepresentable {
    @Binding var text: String
    var backgroundColor: UIColor

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextEditor

        init(parent: CustomTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.backgroundColor = backgroundColor
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

struct TextEditorView: View {
    @Binding public var text: String
    public let keyboardType: UIKeyboardType
    
    var body: some View {
        VStack {
            CustomTextEditor(text: $text, backgroundColor: UIColor(Color.AppColors.text))
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .autocorrectionDisabled()
                .keyboardType(self.keyboardType)
                .padding()
                .background(Color.AppColors.text)
                .cornerRadius(Constants.View.cornerRadius)
                .frame(height: 200)
        }
    }
}

#Preview {
    TextEditorView(text: .constant("Text editor"), keyboardType: .default)
}
