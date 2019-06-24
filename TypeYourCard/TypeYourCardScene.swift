//
//  TypeYourCardScene.swift
//  TypeYourCard
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

fileprivate extension AnyTransition {
    static var textFieldSlide: AnyTransition {
        let slide = AnyTransition.asymmetric(insertion: AnyTransition.move(edge: .trailing),
                                             removal: AnyTransition.move(edge: .leading))
        return  slide.combined(with: .opacity)    }
}

struct PayCardInputField:  Hashable { 
    let title: String
    let path: KeyPath<PayCard, String>
    
    static var all: [PayCardInputField] = [
    .init(title: "Card Number", path: \PayCard.number),
    .init(title: "Cardholder Name", path: \PayCard.holderName),
    .init(title: "Valid Thru", path: \PayCard.validThru),
    .init(title: "Security Code (CVV)", path: \PayCard.cvc)
    ]
}

struct TypeYourCardScene : View {
    
    @State var currentTypedField = PayCardInputField.all.first!
    @State var isLast = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            CardView()
            Text("Type in you card details:")
                .font(.system(size: 27))
                .fontWeight(.bold)
            CardInputView(field: currentTypedField)
            .transition(.textFieldSlide)
            HStack {
                Spacer()
                Button(action: { withAnimation { self.goNextField() } },
                       label: { Text(self.isLast ? "DONE" : "NEXT") })
            }
            Spacer()
        }
    }
        
    private func goNextField() {
        guard isLast == false else { return }
        
        let currentFieldIndex = PayCardInputField.all.firstIndex(of: currentTypedField)!
        let nextIndex = PayCardInputField.all.index(after: currentFieldIndex)
        
        let field = PayCardInputField.all[nextIndex]
        currentTypedField = field
        isLast = nextIndex == (PayCardInputField.all.count - 1)
    }
}


#if DEBUG
struct TypeYourCardScene_Previews : PreviewProvider {
    static var previews: some View {
        TypeYourCardScene().padding(20).environmentObject(PayCard())
    }
}
#endif
