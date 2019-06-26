//
//  KeyboardTypeSetter.swift
//  TypeYourCard
//
//  Created by alexej_ne on 26.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

final class KeyboardTypeSetter {
    var keyboardType: UIKeyboardType = .default
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(didBegin(notification:)), name: UITextField.textDidBeginEditingNotification, object: nil)
    }
    
    @objc func didBegin(notification: Notification) {
        
        if let tf = notification.object as? UITextField {
            tf.keyboardType = keyboardType
        }
        
    }
}
let keyboardTypeSetter = KeyboardTypeSetter()
