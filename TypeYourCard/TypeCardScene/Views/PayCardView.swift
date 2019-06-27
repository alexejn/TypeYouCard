//
//  CardView.swift
//  TypeYourCard
//
//  Created by Alexej Nenastev on 16.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

struct GoldBorder: ViewModifier {
    let padding: Length = 4
    let cornerRadius: Length = 10
    let visible: Bool
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .border(Color(0xC0AE5B),
                    width: visible ? 2 : 0,
                    cornerRadius: cornerRadius)
            .padding(-padding)
            .padding(.bottom, 2)
    }
}

fileprivate struct FrontCardSide: View {
    @EnvironmentObject var environment: TypeCardEnvironment
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                PayServiceLogoView()
            }
            Spacer(minLength: 30)
            HStack {
                PlaceholderText(placeholder: "XXXX", text: environment.onCardNumberPart1)
                Spacer()
                PlaceholderText(placeholder: "XXXX", text: environment.onCardNumberPart2)
                Spacer()
                PlaceholderText(placeholder: "XXXX", text: environment.onCardNumberPart3)
                Spacer()
                PlaceholderText(placeholder: "XXXX", text: environment.onCardNumberPart4)
                }
                .modifier(GoldBorder(visible: environment.currentInputField == PayCardField.number))
                .font(.cardNumberField)
                .foregroundColor(.white)
            
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text("CARDHOLDER NAME")
                        .font(Font.custom("Lucida Grande", size: 13))
                    PlaceholderText(placeholder: "NAME SURNAME",
                                    text: environment.onCardCardholerName,
                                    showPlaceholderWhileTyping: false)
                        .font(.cardRegularField)
                        .modifier(GoldBorder(visible: environment.currentInputField == PayCardField.holder))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 3) {
                    Text("VALID THRU")
                        .font(Font.custom("Lucida Grande", size: 13))
                    PlaceholderText(placeholder: "MM/YY", text: environment.onCardValidThru)
                        .font(.cardRegularField)
                        .modifier(GoldBorder(visible: environment.currentInputField == PayCardField.validThru))
                }
                }
                .foregroundColor(Color.white)
        }.padding(20)
        .animation(Animation.FlipOtherSide.hideSideWhileFlip, value: environment.currentInputField) 
    }
}

fileprivate struct BackCardSide: View {
    @EnvironmentObject var environment: TypeCardEnvironment
    
    var body: some View {
        VStack(spacing: 15) {
            Color.black.frame(height: 60)
                .padding([.leading, .trailing], -20)
                .padding(.top, 15)
            HStack {
                Color.gray.frame(width: 240, height: 40, alignment: .center)
                ZStack {
                    Color.white
                        PlaceholderText(placeholder: "XXX", text: environment.onCardCVV)
                        .font(.cardRegularField)
                        .padding(.bottom, 3)
                }.frame(width: 40, height: 32)
                .cornerRadius(6)
                .modifier(GoldBorder(visible: true))
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                PayServiceLogoView()
            }
        }.padding(20)
        .rotation3DEffect(.degrees(-180), axis: (x: 0, y: 1, z: 0))
            .animation(Animation.FlipOtherSide.hideSideWhileFlip, value: environment.validThru)
    }
}

struct PayCardView : View {
    @EnvironmentObject var environment: TypeCardEnvironment
    
    private var isBackSide: Bool { environment.currentInputField == .cvv  }
    
    var body: some View {
        ZStack {
            BackCardSide().opacity(isBackSide ? 1 : 0)
            FrontCardSide().opacity(isBackSide ? 0 : 1)
        }
        .background(Color(red: 59/255, green: 58/255, blue: 61/255), cornerRadius: 16)
        .aspectRatio(1.7, contentMode: .fit) //1.46 original
        .shadow(radius: 10)
        .rotation3DEffect(.degrees(isBackSide ? -180 : 0), axis: (x: 0, y: 1, z: 0))
        .animation(environment.filled ? Animation.FlipOtherSide.flip : nil)
    }
}

#if DEBUG
struct CardView_Previews : PreviewProvider {
    static var previews: some View {
        PayCardView().padding(20).environmentObject(TypeCardEnvironment())
        
    }
}
#endif
