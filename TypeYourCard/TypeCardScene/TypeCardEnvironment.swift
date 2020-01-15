//
//  TypeCardEnvironment.swift
//  TypeCardEnvironment
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI
import Combine

final class TypeCardEnvironment: ObservableObject {
    let didChange = PassthroughSubject<TypeCardEnvironment, Never>()
    private func notify() {   didChange.send(self)  }
    
    var currentInputField: PayCardField = .number { didSet {  notify() } }
    
    var number: String = "" {
        didSet {
            guard oldValue != number else { return }
            cardNumberDidSet(oldValue: oldValue)
            payService = number.count > 3 ? .MasterCard : nil
            notify()
        }
    }
    
    var holderName: String = ""  {
        didSet {
            guard oldValue != holderName else { return }
            self.holderName = holderName.uppercased().onlyLetter 
            notify()
        }
    }
    
    var validThru: String = ""   {
        didSet {
            guard oldValue != validThru else { return }
            validThruDidSet(oldValue: oldValue)
            notify()
        }
    }
 
    var cvv: String = "" {
        didSet {
            guard oldValue != cvv else { return }
            self.cvv = cvv.onlyNumeric[0..<3]
            notify()
        }
    }
    
    var payService: PayService? = nil { didSet { notify() } }
    
    func clear() {
        currentInputField = .number
        holderName = ""
        validThru = ""
        cvv = ""
        payService = nil
        number = ""
    }
    
    var canGoNext: Bool {
        return isInputDataValid(for: currentInputField)
    }
     
    func goToNextField() {
        guard let toField = currentInputField.nextForInput else { return }
        currentInputField = toField
    }
    
    func goToPreviousField() {
        guard let toField = currentInputField.prevForInput else { return }
        currentInputField = toField
    }
    
    func goToIfCan(field: PayCardField) {
        guard field != currentInputField else { return }
        
        if field.isFirstInput {
            currentInputField = field
        } else {
            guard let prev = field.prevForInput, isInputDataValid(for: prev) else { return }
           currentInputField = field
        }
    }
    
    private func isInputDataValid(for field:  PayCardField) -> Bool {
        switch field {
        case .number: return PayCard.tryGetValidNumber(number) != nil
        case .holder: return PayCard.tryGetCardHolder(holderName) != nil
        case .validThru: return PayCard.tryGetValidThru(validThru) != nil
        case .cvv: return PayCard.tryGetValidCVV(cvv) != nil
        }
    }
}

// On PayCard
extension TypeCardEnvironment {
    var onCardNumberPart1: String  { number.onlyNumeric[0..<4].fixFontIssue() }
    var onCardNumberPart2: String  { number.onlyNumeric[4..<8].fixFontIssue() }
    var onCardNumberPart3: String  { number.onlyNumeric[8..<12].fixFontIssue() }
    var onCardNumberPart4: String  { number.onlyNumeric[12..<16].fixFontIssue() }
    
    var onCardCardholerName: String { holderName.uppercased().onlyLetter }
    var onCardValidThru: String { validThru.filter(allowedSymbols: "1234567890/")[0..<5].fixFontIssue() }
    var onCardCVV: String { cvv[0..<3].fixFontIssue() }
}

fileprivate extension TypeCardEnvironment {
    func cardNumberDidSet(oldValue: String) {
        var tempNumb = number
        
        if oldValue == "\(tempNumb) " {
            number = tempNumb
        } else {
            var resultStr = ""
            tempNumb = tempNumb.onlyNumeric[0..<16]
            
            let partsCount = tempNumb.count / 4
            for _ in 0...partsCount {
                let part = tempNumb.prefix(4)
                resultStr = "\(resultStr) \(part)"
                if tempNumb.count >= 4 {
                    tempNumb.removeFirst(4)
                }
            }
            
            number = resultStr.trimmingCharacters(in: .whitespaces)
        }
    }
    
    func validThruDidSet(oldValue: String) {
        var onCard = validThru.onlyNumeric[0..<5]
        
        if oldValue == "\(validThru)/" {
            self.validThru = "\(onCard.prefix(1))"
        } else if onCard.count > 1 {
            let part1 = "\(onCard.prefix(2))"
            onCard.removeFirst(2)
            let part2 = onCard
            self.validThru = "\(part1)/\(part2)"
        } else {
            self.validThru = onCard
        }
    }
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
