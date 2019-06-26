//
//  ActionButton.swift
//  TypeYourCard
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

struct ActionButton : View {
    var title: String 
 
    private var shape: some View {
        GeometryReader { geometry in
            Path { path in
                let height = geometry.size.height
                let frame = geometry.frame(in: .local)
                let bigCornerRadius = height/2
                
                
                path.addRoundedRect(in: frame,
                                    cornerSize: CGSize(width: bigCornerRadius,
                                                       height: bigCornerRadius),
                                    style: .circular,
                                    transform: .identity)
                
                
                let halfFrame = CGRect(x: frame.midX, y: frame.minY, width: frame.width / 2, height: frame.height / 1.6)
                let smallCornerRadius = halfFrame.height / 4
                
                path.addRoundedRect(in: halfFrame,
                                    cornerSize: CGSize(width: smallCornerRadius,
                                                       height: smallCornerRadius),
                                    style: .circular,
                                    transform: .identity)
                }.fill(LinearGradient.forActionButton)
        }
    }
        
    var body: some View {
        ZStack {
            shape.shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3)
            Text(title)
                .font(.headline)
            
        }
        .aspectRatio(216/117, contentMode: .fit)
        .frame(height: 60)
        .foregroundColor(.white)
        
    }
}

#if DEBUG
struct ActionButton_Previews : PreviewProvider {
    static var previews: some View {
        ActionButton(title: "Next")
    }
}
#endif
