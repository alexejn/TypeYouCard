//
//  TypeYourCardScene.swift
//  TypeYourCard
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

extension PayCardField {
    
    var isFirstInput: Bool {
        self.rawValue == PayCardField.allCases.map { $0.rawValue }.min()!
    }
    
    var isLastInput: Bool {
        self.rawValue == PayCardField.allCases.map { $0.rawValue }.max()!
    }
    
    var buttonTitle: String {
        isLastInput ? "DONE" : "Next"
    }
    
    var nextForInput: PayCardField? {
        PayCardField(rawValue: rawValue + 1)
    }
    
    var prevForInput: PayCardField? {
        PayCardField(rawValue: rawValue - 1)
    }
}

struct TypeCardScene : View {
    @ObjectBinding var environment = TypeCardEnvironment()
  
    private var textFieldBinding: Binding<String> {
        switch environment.currentInputField {
        case .number: return $environment.number
        case .holder: return $environment.holderName
        case .cvv: return $environment.cvv
        case .validThru: return $environment.validThru
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 14) {
            PayCardView().layoutPriority(1)
            HStack {
                Text("Type in you card details:")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                Spacer()
            }
            VStack(alignment: .trailing, spacing: 10) {
                PayCardFieldInputView(field: environment.currentInputField,
                                      binding: textFieldBinding,
                                      isFirstResponder: true)
                    .transition(.slideRightToLeft)
                HStack {
                    Button(action: goNext) {  ActionButton(title: self.environment.currentInputField.buttonTitle) }
                        .opacity( environment.canGoNext ? 1 : 0.6)
                }
            }
            Spacer()
        }.padding(20)
        .environmentObject(environment).onAppear {
                self.environment.clear()
        }
        
    }
    
    private func goNext() {
        guard environment.canGoNext else { return }
        
        if environment.currentInputField.isLastInput {
            withAnimation { environment.clear() }
        } else {
            withAnimation { environment.goToNextField() }
        }
    }
}


#if DEBUG
struct TypeYourCardScene_Previews : PreviewProvider {
    static var environment:  TypeCardEnvironment {
        let env = TypeCardEnvironment()
        env.number = "4124"
        return env
    }
    
    
    static var previews: some View {
        TypeCardScene(environment: environment)
            .padding(20)
    }
}
#endif
