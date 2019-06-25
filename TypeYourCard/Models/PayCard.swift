//
//  PayCard.swift
//  TypeYourCard
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI
import Combine

final class PayCard: BindableObject {
    let didChange = PassthroughSubject<PayCard, Never>()
    
    var number: String = ""  { didSet { notify() }  }
    var holderName: String = ""  {  didSet { notify() } }
    var validThru: String = "" {  didSet { notify() } }
    var cvc: String = ""  {  didSet { notify() } }
    
    private func notify() {
        didChange.send(self)
    }
    
    var isCVVProviding: Bool = false {  didSet { notify() } }
    
    var holderPlaceHolder: String {
        var placeholder = "NAME LASTNAME"
        placeholder.removeFirst(holderName.count)
        return placeholder
    }
}
 
