//
//  PayCardInput.swift
//  TypeYourCard
//
//  Created by alexej_ne on 25.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//
import SwiftUI

enum PayCardInput: CaseIterable {
    case number
    case holder
    case validThru
    case cvv
    
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
