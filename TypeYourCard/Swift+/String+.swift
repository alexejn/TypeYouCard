//
//  String+.swift
//  TypeYourCard
//
//  Created by alexej_ne on 26.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//
import Foundation

extension String {
    
    public var onlyNumeric: String {  filter(allowedSymbols:  "0123456789")  } 
    
    public var onlyLetter: String {  filter(allowedSymbols:  " QWERTYUIOPASDFGHJKLZXCVBNM'")  }
    
    public func filter(allowedSymbols: String ) -> String {
        let characterSet = CharacterSet(charactersIn: allowedSymbols).inverted
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
