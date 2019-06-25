//
//  NextButton.swift
//  TypeYourCard
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI
prefix operator ⋮
prefix func ⋮(hex:UInt32) -> Color {
    return Color(hex)
}

extension Color {
    init(_ hex: UInt32, opacity:Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

let hexColor:(UInt32) -> (Color) = {
    return Color($0)
}


fileprivate extension LinearGradient {
    static var nextButton: LinearGradient {
        LinearGradient(gradient: .init(colors: [Color(0x6547B4), Color(0xA82786)]),
                       startPoint: .init(x: 0, y: 0.2),
                       endPoint: .init(x: 1, y: 0.9))
    }
}

struct NextButton : View {
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
                }.fill(LinearGradient.nextButton) 
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
struct NextButton_Previews : PreviewProvider {
    static var previews: some View {
        NextButton(title: "Next")
    }
}
#endif
