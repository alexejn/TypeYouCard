//
//  MasterCardLogoView.swift
//  TypeYourCard
//
//  Created by alexej_ne on 27.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

fileprivate extension Animation {
    static var leftArcAppearance: Animation {
        .basic(duration: 5)
    }
}

//extension AnyTransition {
//    static var slideRightToLeft: AnyTransition {
//        let slide = AnyTransition.asymmetric(insertion: AnyTransition.move(edge: .trailing),
//                                             removal: AnyTransition.move(edge: .leading))
//        return  slide.combined(with: .opacity)
//    }
//}

fileprivate extension Animation {
    static var circleDraw: Animation {
        basic(duration: 0.8, curve: .easeInOut)
    }
    
    static var fillColor: Animation {
        basic(duration: 0.5, curve: .linear).delay(1.1)
    }
}

struct CircleShape: Shape {
    var endPath: Double
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        let radius = rect.height / 2
        let center = CGPoint(x: radius, y: rect.midY)
        path.addArc(center: center,
                    radius: radius,
                    startAngle: .degrees(0),
                    endAngle: .degrees(endPath),
                    clockwise: false)
        
        return path
    }
    
    var animatableData: AnimatablePair<Double, Double> {
        get { .init(endPath, 0) }
        set {  endPath = newValue.first }
    }
    
}

struct CircleView: View {
    var visible: Bool = false
    var color: Color
    var animationDelay: Double = 0
    var opacity: Double = 0.6
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .opacity(visible ? opacity : 0)
                .animation(.fillColor)
            
            CircleShape(endPath: self.visible ? 360 : 0)
                .stroke(color, lineWidth: 1)
                .animation(Animation.circleDraw.delay(animationDelay))
                .rotationEffect(.degrees(self.visible ? 360 : 0), anchor: UnitPoint.center)
        }.aspectRatio(1, contentMode: .fit)
    }
}

struct MasterCardLogoView : View {
    @State private var visible: Bool = false
    var height: Length = 50
    private let aspectRatio: Length = 1.64
    private var offset: Length { return height / (2 * aspectRatio)}
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Color(0xEA011A))
                .opacity(visible ? 1 : 0)
                .animation(.fillColor)
                .frame(height: height)
                .offset(x: -offset, y: 0)

            CircleView(visible: self.visible,
                       color: Color(0xEA011A) )
                .zIndex(1)
                .offset(x: -offset, y: 0)
            
            CircleView(visible: self.visible,
                       color: Color(0xF79F19),
                       animationDelay: 0.3,
                       opacity: 1)
                .offset(x: offset, y: 0)
            }.padding(0)
            .frame(width: height * aspectRatio, height: height)
            .onAppear() {
                if self.visible {
                    self.visible.toggle()
                } else {
                     withAnimation {  self.visible.toggle()
                }
            }
                
        }
    }
}

#if DEBUG
struct MasterCardLogoView_Previews : PreviewProvider {
    static var previews: some View {
        MasterCardLogoView(height: 100)
    }
}
#endif
