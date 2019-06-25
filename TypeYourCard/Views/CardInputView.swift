//
//  CardInputView.swift
//  TypeYourCard
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

class DirtyWork {
    var keyboardType: UIKeyboardType = .default // some default
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(didBegin(notification:)), name: UITextField.textDidBeginEditingNotification, object: nil)
    }
    
    @objc func didBegin(notification: Notification) {
        
        if let tf = notification.object as? UITextField {
            tf.keyboardType = keyboardType
        }
        
    }
}

let dirtyWork = DirtyWork()

struct CardInputView : View {
    @EnvironmentObject var payCard: PayCard
    var field: PayCardInput
    
    var body: some View {
        IDView(content, id: field.title)
    }
    
    private var textFieldBinding: Binding<String> {
        switch field {
        case .number: return $payCard.number
        case .holder: return $payCard.holderName
        case .cvv: return $payCard.cvc
        case .validThru: return $payCard.validThru
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(field.title)
                .font(.system(size: 15))
                .opacity(0.5)
            
            TextField(textFieldBinding, onEditingChanged: { if $0 {
                dirtyWork.keyboardType = self.field.keyboardType
            }})
                .frame(height: 60)
                .border(Color.black, width: 0.3, cornerRadius: 10)
        }
    }
}


#if DEBUG
struct CardInputView_Previews : PreviewProvider {
    static var previews: some View {
        CardInputView(field: .number).padding(20)
    }
}
#endif
