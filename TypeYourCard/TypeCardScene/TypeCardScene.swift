//
//  TypeYourCardScene.swift
//  TypeYourCard
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

fileprivate extension PayCardField {
    
    var isLastInput: Bool {
        self.rawValue == PayCardField.allCases.map { $0.rawValue }.max()!
    }
    
    var buttonTitle: String {
        isLastInput ? "DONE" : "Next"
    }
    
    var nextForInput: PayCardField? {
        PayCardField(rawValue: rawValue + 1)
    }
}

struct TypeCardScene : View {
    @ObjectBinding var environment = TypeCardEnvironment()
  
    private var textFieldBinding: Binding<String> {
        switch environment.currentInputField {
        case .number: return $environment.number
        case .holder: return $environment.holderName
        case .cvv: return $environment.cvc
        case .validThru: return $environment.validThru
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            PayCardView().layoutPriority(1)
            HStack {
                Text("Type in you card details:")
                    .font(.system(size: 27))
                    .fontWeight(.bold)
                Spacer()
            }
            VStack(alignment: .trailing, spacing: 10) {
                PayCardFieldInputView(field: environment.currentInputField, binding: textFieldBinding).transition(.slideRightToLeft)
                HStack {
                    Button(action: goNext) {
                        ActionButton(title: self.environment.currentInputField.buttonTitle)
                    }
                }
            }
            Spacer()
        }.padding(20)
        .environmentObject(environment).onAppear {
                self.environment.clear()
        }
        
    }
    
    private func goNext() {
        if let nextInput = environment.currentInputField.nextForInput {
            environment.currentInputField = nextInput
        } else {
           // done
        }
    }
}


#if DEBUG
struct TypeYourCardScene_Previews : PreviewProvider {
    static var previews: some View {
        TypeCardScene(environment: TypeCardEnvironment())
            .padding(20)
    }
}
#endif
