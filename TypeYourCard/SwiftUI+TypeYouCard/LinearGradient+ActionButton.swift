//
//  LinearGradient+TypeYouCard.swift
//  TypeYourCard
//
//  Created by alexej_ne on 26.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//
import SwiftUI

extension LinearGradient {
    static var forActionButton: LinearGradient {
        LinearGradient(gradient: .init(colors: [Color(0x6547B4), Color(0xA82786)]),
                       startPoint: .init(x: 0, y: 0.2),
                       endPoint: .init(x: 1, y: 0.9))
    }
}
