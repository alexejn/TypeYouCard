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
    
    var body: some View {
        IDView(content, id: field.title)
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(field.title)
                .font(.system(size: 15))
                .opacity(0.5)
            
            TextField(binding, onEditingChanged: { if $0 {
                keyboardTypeSetter.keyboardType = self.field.keyboardType
            }})
                .padding(10)
                .frame(height: 60)
                .border(Color.black, width: 0.3, cornerRadius: 10)
        }
    }
}

#if DEBUG
struct PayCardFieldInputView_Previews : PreviewProvider {
    static var previews: some View {
        PayCardFieldInputView(field: .number, binding: .constant("1234")).padding(20)
    }
}
#endif
