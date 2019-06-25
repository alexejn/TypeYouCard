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
    @EnvironmentObject var payCard: PayCard

    @State var currentTypedField = PayCardInput.number
 
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            CardView().layoutPriority(1)
            HStack {
                Text("Type in you card details:")
                    .font(.system(size: 27))
                    .fontWeight(.bold)
                Spacer()
            }
            VStack(alignment: .trailing, spacing: 10) {
                CardInputView(field: currentTypedField)
                    .transition(.textFieldSlide)
                HStack {
                    Button(action: { self.goNextField() },
                           label: { NextButton(title: self.payCard.isCVVProviding ? "DONE" : "Next") })
                }
            }
            Spacer()
        }
    }
        
    private func goNextField() {
        guard payCard.isCVVProviding == false else { return }
        
        let currentFieldIndex = PayCardInput.allCases.firstIndex(of: currentTypedField)!
        let nextIndex = PayCardInput.allCases.index(after: currentFieldIndex)
        
        let field = PayCardInput.allCases[nextIndex]
        withAnimation { currentTypedField = field }
        
        withAnimation(.rotateCard) { payCard.isCVVProviding = nextIndex == (PayCardInput.allCases.count - 1) }
    }
}


#if DEBUG
struct TypeYourCardScene_Previews : PreviewProvider {
    static var previews: some View {
        TypeYourCardScene().padding(20).environmentObject(PayCard())
    }
}
#endif
