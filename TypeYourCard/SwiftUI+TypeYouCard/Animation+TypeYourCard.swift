//
//  Animation+TypeYouCard.swift
//  TypeYourCard
//
//  Created by alexej_ne on 26.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

extension Animation {
    struct FlipOtherSide {
        private static let duration: Double = 0.3
        
        static var hideSideWhileFlip: Animation {
            Animation.basic(duration: 0.001, curve: .linear).delay(duration/2)
        }
        
        static var flip: Animation {
            Animation.basic(duration: duration, curve: .linear)
        }
    }
    
    static var withoutAnimation: Animation {
        Animation.basic(duration: 0, curve: .linear)
    }
}
