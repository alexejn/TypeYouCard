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

struct TypeYourCardScene : View {
    
    private let payCardFields = PayCardField.allCases
    @State var currentTypedField = PayCardField.number
    @State var isLast = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            CardView()
            Text("Type in you card details:")
                .font(.system(size: 27))
                .fontWeight(.bold)
            CardInputView(title: currentTypedField.rawValue) 
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
        
        let currentFieldIndex = payCardFields.firstIndex(of: currentTypedField)!
        let nextIndex = payCardFields.index(after: currentFieldIndex)
        
        let field = payCardFields[nextIndex]
        currentTypedField = field
        isLast = nextIndex == (payCardFields.count - 1)
    }
}


#if DEBUG
struct TypeYourCardScene_Previews : PreviewProvider {
    static var previews: some View {
        TypeYourCardScene().padding(20).environmentObject(PayCard())
    }
}
#endif
