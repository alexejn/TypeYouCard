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

struct MasterCardLogoView : View {
    
    @State private var animate: Bool = false
    
    var body: some View {
        VStack {
//        GeometryReader { geometry in
//            Path { path in
//                let frame =  geometry.frame(in: .local)
//                let center = CGPoint(x: frame.midX, y: frame.midY)
//
//                path.addArc(center: center,
//                            radius: self.animate ? 100 : 50,
//                            startAngle: .degrees(0),
//                            endAngle: .degrees(self.animate ? 360: 50 ),
//                            clockwise: true)
//
//                }.stroke(Color.red)
//            }
            Circle()
                 .trim(from: 0, to: animate ? 0.7 : 0)
                //.stroke(Color.red, lineWidth: 2)
                .foregroundColor(.red)
                .rotationEffect(.degrees(animate ? 180 : 0))
               // .animation(Animation.basic(), animate)
            
            
            Button(action: {  withAnimation { self.animate.toggle()  } }) {
                Text("Go animate")
            }
        }
    }
}

#if DEBUG
struct MasterCardLogoView_Previews : PreviewProvider {
    static var previews: some View {
        MasterCardLogoView()
    }
}
#endif
