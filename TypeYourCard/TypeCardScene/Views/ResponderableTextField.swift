//
//  ResponderableTextField.swift
//  TypeYourCard
//
//  Created by Alexej Nenastev on 27.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

struct ResponderableTextField: UIViewRepresentable {
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        var didBecomeFirstResponder = false
        
        init(text: Binding<String>) {
            $text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
    }
    
    @Binding var text: String
    var isFirstResponder: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    func makeUIView(context: UIViewRepresentableContext<ResponderableTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.keyboardType = keyboardType
        return textField
    }
    
    func makeCoordinator() -> ResponderableTextField.Coordinator {
        return Coordinator(text: $text)
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<ResponderableTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}
