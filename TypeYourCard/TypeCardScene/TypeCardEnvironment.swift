//
//  TypeCardEnvironment.swift
//  TypeCardEnvironment
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI
import Combine

final class TypeCardEnvironment: BindableObject {
    let didChange = PassthroughSubject<TypeCardEnvironment, Never>()
    private func notify() {   didChange.send(self)  }
    
    var number: String = "" {
        didSet {
            onlyNumericNumber = number.onlyNumeric
            notify()
        }
    }
    private var onlyNumericNumber: String = ""
    
    var currentInputField: PayCardField = .number { didSet { notify() }  }
    var holderName: String = ""  {  didSet { notify() } }
    var validThru: String = "" {  didSet { notify() } }
    var cvc: String = ""  {  didSet { notify() } }
    var payService: PayService? = nil { didSet { notify() } }
    
    var filled: Bool  { validThru.isEmpty == false }
    
    func clear() {
        currentInputField = .number
        holderName = ""
        validThru = ""
        cvc = ""
        payService = nil
        number = ""
    }
    
}
// On PayCard
extension TypeCardEnvironment {
    var onCardNumberPart1: String  { onlyNumericNumber[0..<4].fixFontIssue() }
    var onCardNumberPart2: String  { onlyNumericNumber[4..<8].fixFontIssue() }
    var onCardNumberPart3: String  { onlyNumericNumber[8..<12].fixFontIssue() }
    var onCardNumberPart4: String  { onlyNumericNumber[12..<16].fixFontIssue() }
    
    var onCardCardholerName: String { holderName.uppercased().onlyLetter}
    var onCardValidThru: String { validThru.onlyNumeric.fixFontIssue() }
    var onCardCVV: String { cvc.onlyNumeric[0..<3].fixFontIssue() }
}


fileprivate extension String {
    
    func fixFontIssue() -> String {
        let replacments: [Character: Character] = [
            "1" : "a",
            "2" : "b",
            "3" : "c",
            "4" : "d",
            "5" : "e",
            "6" : "f",
            "7" : "g",
            "8" : "h",
            "9" : "i",
            "0" : "k",
        ]
        
        return String(self.map { replacments[$0] ?? $0 })
    }
}
