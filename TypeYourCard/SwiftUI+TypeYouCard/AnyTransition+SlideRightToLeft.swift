//
//  AnyTransition+SlideRightToLeft.swift
//  TypeYourCard
//
//  Created by alexej_ne on 26.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//
import SwiftUI

extension AnyTransition {
    static var slideRightToLeft: AnyTransition {
        let slide = AnyTransition.asymmetric(insertion: AnyTransition.move(edge: .trailing),
                                             removal: AnyTransition.move(edge: .leading))
        return  slide.combined(with: .opacity) 
    }
}
