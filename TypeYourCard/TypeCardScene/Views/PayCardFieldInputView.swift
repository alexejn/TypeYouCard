//
//  CardInputView.swift
//  TypeYourCard
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

fileprivate extension PayCardField {
    var title: String  {
        switch self {
        case .number: return "Card Number"
        case .holder: return "Cardholder Name"
        case .validThru: return "Valid Thru"
        case .cvv: return "Security Code (CVV)"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .holder: return .default
        default: return .numberPad
        }
    }
}

struct PayCardFieldInputView : View {
    var field: PayCardField
    var binding: Binding<String>
    var isFirstResponder: Bool
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 6) {
            Text(field.title)
                .font(.system(size: 15))
                .opacity(0.5)
            
            ResponderableTextField(text: binding,
                                   isFirstResponder: isFirstResponder,
                                   keyboardType: field.keyboardType)
                .padding(10)
                .frame(height: 50)
                .border(Color.black, width: 0.3)
                .cornerRadius(10)
                
        }.id(field.title)
    }
}

#if DEBUG
struct PayCardFieldInputView_Previews : PreviewProvider {
    static var previews: some View {
        PayCardFieldInputView(field: .number, binding: .constant("1234"), isFirstResponder: true).padding(20)
    }
}
#endif
