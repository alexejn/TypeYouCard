//
//  CardView.swift
//  TypeYourCard
//
//  Created by Alexej Nenastev on 16.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

fileprivate extension Animation {
    private static let rotateDuration:Double = 0.3
    
    static var cardHideDelayed: Animation {
        Animation.basic(duration: 0.001, curve: .linear).delay(rotateDuration/2)
    }
    
    static var rotateCard: Animation {
        Animation.basic(duration: rotateDuration, curve: .linear)
    }
}

fileprivate struct Logo: View {
    var body: some View {
        Text("LOGO")
    }
}

fileprivate struct FrontCardSide: View {
    @EnvironmentObject var payCard: PayCard
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Logo()
            }
            Spacer(minLength: 36)
            HStack {
                Text("4243")
                Spacer()
                Text("1111")
                Spacer()
                Text("4213")
                Spacer()
                Text("9876")
                }
                .font(.system(size: 28))
                .foregroundColor(.white)
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Text("CARDHOLDER NAME")
                        .font(.caption)
                    Text("NAME SURNAMEeee")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("VALID THRU").font(.caption)
                    Text("MM/YY")
                }
                }
        }.padding(20)
        .animation(.cardHideDelayed)
    }
}

fileprivate struct BackCardSide: View {
    @EnvironmentObject var payCard: PayCard

    var body: some View {
        VStack(spacing: 10) {
            Color.black.frame(height: 60)
                .padding([.leading, .trailing], -20)
                .padding(.top, 15)
            HStack {
                Color.gray
                TextField($payCard.cvc, placeholder: Text("XXX")) 
            }
            Spacer()
            HStack {
                Spacer()
                Logo()
            }
        }.padding(20)
        .rotation3DEffect(.degrees(-180), axis: (x: 0, y: 1, z: 0))
        .animation(.cardHideDelayed)
    }
}


struct CardView : View {
    @EnvironmentObject var payCard: PayCard
    @State var isFront = false
    
    var body: some View {
        ZStack {
            BackCardSide().opacity(isFront ? 0 : 1)
            FrontCardSide().opacity(isFront ? 1 : 0)
        }
        .background(Color(red: 59/255, green: 58/255, blue: 61/255), cornerRadius: 20)
        .aspectRatio(1.46, contentMode: .fit)
        .rotation3DEffect(.degrees(isFront ? 0 : -180), axis: (x: 0, y: 1, z: 0))
        .tapAction { withAnimation(.rotateCard) { self.isFront.toggle() } }
    }
}

#if DEBUG
struct CardView_Previews : PreviewProvider {
    static var previews: some View {
        CardView().padding(20).environmentObject(PayCard())
    }
}
#endif
