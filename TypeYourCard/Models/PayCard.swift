//
//  PayCard.swift
//  TypeYourCard
//
//  Created by alexej_ne on 26.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//
import Foundation

struct PayCard {
    let number: String
    let holder: String
    let validThru: Date
    let cvv: Int
}


extension PayCard {
    
    static func tryGetValidNumber(_ str: String) -> String? {
        let number = String(str.onlyNumeric.prefix(16))
        return number.count == 16 ? number : nil
    }
    
    static func tryGetCardHolder(_ str: String) -> String? {
        let holder = str.uppercased().onlyLetter.trimmingCharacters(in: .whitespaces)
        return holder.count > 3 ? holder : nil
    }
    
    static func tryGetValidThru(_ str: String) -> Date? {
        let validThru = str.filter(allowedSymbols: "1234567890/")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/YY"
        return dateFormatter.date(from: validThru)
    }
    
    static func tryGetValidCVV(_ str: String) -> Int? {
        let cvv = String(str.onlyNumeric.prefix(3))
        guard cvv.count == 3 else { return nil}
        return Int(cvv)
    }
}
