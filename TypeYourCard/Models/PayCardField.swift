//
//  PayCardField.swift
//  TypeYourCard
//
//  Created by alexej_ne on 25.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//
import SwiftUI

enum PayCardField: Int, CaseIterable {
    // Int - is input order
    case number
    case holder
    case validThru
    case cvv
}
