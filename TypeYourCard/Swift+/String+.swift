//
//  String+.swift
//  TypeYourCard
//
//  Created by alexej_ne on 26.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//
import Foundation

extension String {
    
    public var onlyNumeric: String {
        let characterSet = CharacterSet(charactersIn: "0123456789").inverted
        return components(separatedBy: characterSet)
            .joined()
    }
    
    public var onlyLetter: String {
        let characterSet = CharacterSet(charactersIn: " QWERTYUIOPASDFGHJKLZXCVBNM'").inverted
        return components(separatedBy: characterSet)
            .joined()
    }
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        guard range.lowerBound <= self.count else { return "" }
        
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
