//
//  CardView.swift
//  TypeYourCard
//
//  Created by Alexej Nenastev on 16.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

fileprivate struct FrontCardSide: View {
    @EnvironmentObject var environment: TypeCardEnvironment
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                PayServiceLogoView()
            }
            Spacer(minLength: 65)
            HStack {
                PlaceholderText(placeholder: "XXXX", text: environment.onCardNumberPart1)
                Spacer()
                PlaceholderText(placeholder: "XXXX", text: environment.onCardNumberPart2)
                Spacer()
                PlaceholderText(placeholder: "XXXX", text: environment.onCardNumberPart3)
                Spacer()
                PlaceholderText(placeholder: "XXXX", text: environment.onCardNumberPart4)
                }
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
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 3) {
                    Text("VALID THRU")
                        .font(Font.custom("Lucida Grande", size: 13))
                    PlaceholderText(placeholder: "MM/YY", text: environment.onCardValidThru)
                        .font(.cardRegularField)
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
                .cornerRadius(3)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                PayServiceLogoView()
            }
        }.padding(20)
        .rotation3DEffect(.degrees(-180), axis: (x: 0, y: 1, z: 0))
        .animation(Animation.FlipOtherSide.hideSideWhileFlip)
    }
}

struct PayCardView : View {
    @EnvironmentObject var typeCardEnvironment: TypeCardEnvironment
    
    private var isBackSide: Bool { typeCardEnvironment.currentInputField == .cvv  }
    
    var body: some View {
        ZStack {
            BackCardSide().opacity(isBackSide ? 1 : 0)
            FrontCardSide().opacity(isBackSide ? 0 : 1)
        }
        .background(Color(red: 59/255, green: 58/255, blue: 61/255), cornerRadius: 16)
        .aspectRatio(1.46, contentMode: .fit)
        .shadow(radius: 10)
        .rotation3DEffect(.degrees(isBackSide ? -180 : 0), axis: (x: 0, y: 1, z: 0))
        .animation(Animation.FlipOtherSide.flip)//, value: isBackSide)
    }
}

#if DEBUG
struct CardView_Previews : PreviewProvider {
    static var previews: some View {
        PayCardView().padding(20).environmentObject(TypeCardEnvironment())
    }
}
#endif
