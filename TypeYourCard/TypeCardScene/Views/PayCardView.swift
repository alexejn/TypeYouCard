//
//  CardView.swift
//  TypeYourCard
//
//  Created by Alexej Nenastev on 16.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

struct GoldBorder: ViewModifier {
    let visible: Bool
    let cornerRadius: Length = 10
    var padding: EdgeInsets = .init(top: 2, leading: 6, bottom: 5, trailing: 6)
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .border(Color(0xC0AE5B),
                    width: visible ? 2 : 0,
                    cornerRadius: cornerRadius)
            .padding(EdgeInsets(top: -padding.top,
                                leading: -padding.leading,
                                bottom: -padding.bottom,
                                trailing:  -padding.trailing))
        
    }
}
//MARK: Front side
fileprivate struct FrontCardSide: View {
    @EnvironmentObject var environment: TypeCardEnvironment
    
    var body: some View {
        VStack {
            HStack {
                Text(" ").frame(height: 30)
                Spacer()
                PayServiceLogoView()
            }
            Spacer(minLength: 6)
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
                .tapAction { self.goTo(field: .number) } 
            Spacer(minLength: 6)
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text("CARDHOLDER NAME")
                        .font(Font.custom("Lucida Grande", size: 13))
                    PlaceholderText(placeholder: "NAME SURNAME",
                                    text: environment.onCardCardholerName,
                                    showPlaceholderWhileTyping: false)
                        .font(.cardRegularField)
                        .modifier(GoldBorder(visible: environment.currentInputField == PayCardField.holder))
                         .tapAction { self.goTo(field: .holder) }
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 3) {
                    Text("VALID THRU")
                        .font(Font.custom("Lucida Grande", size: 13))
                    PlaceholderText(placeholder: "MM/YY", text: environment.onCardValidThru)
                        .font(.cardRegularField)
                        .modifier(GoldBorder(visible: environment.currentInputField == PayCardField.validThru))
                        .tapAction { self.goTo(field: .validThru) }
                }
                }
                .foregroundColor(Color.white)
        }.padding(18)
        .animation(Animation.FlipOtherSide.hideSideWhileFlip)
    }
    
    private func goTo(field: PayCardField) {
        withAnimation { self.environment.goToIfCan(field: field)  }
    }
}

//MARK: Back side
fileprivate struct BackCardSide: View {
    @EnvironmentObject var environment: TypeCardEnvironment
    
    var body: some View {
        VStack(spacing: 15) {
            Color.black.frame(height: 60)
                .padding([.leading, .trailing], -18)
                .padding(.top, 11)
            HStack {
                Color.gray.frame(width: 240, height: 40, alignment: .center)
                ZStack {
                    Color.white
                        PlaceholderText(placeholder: "XXX", text: environment.onCardCVV)
                        .font(.cardRegularField)
                        .padding(.bottom, 3)
                }.frame(width: 40, height: 32)
                .cornerRadius(6)
                .modifier(GoldBorder(visible: true,
                                     padding: .init(top: 5, leading: 5, bottom: 5, trailing: 5)))
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                PayServiceLogoView()
                    .animation(nil)
            }
        }.padding(18)
        .rotation3DEffect(.degrees(-180), axis: (x: 0, y: 1, z: 0))
        .animation(Animation.FlipOtherSide.hideSideWhileFlip)
        .tapAction(environment.goToPreviousField)
        
    }
}

//MARK: PayCard
struct PayCardView : View {
    @EnvironmentObject var environment: TypeCardEnvironment
    
    private var isBackSide: Bool { environment.currentInputField == .cvv  }
    
    var body: some View {
        ZStack {
            BackCardSide().opacity(isBackSide ? 1 : 0)
            FrontCardSide().opacity(isBackSide ? 0 : 1)
        }
        .background(Color(0x191622), cornerRadius: 16)
        .aspectRatio(1.46, contentMode: .fit) //1.46 original
        .shadow(radius: 10)
        .rotation3DEffect(.degrees(isBackSide ? -180 : 0), axis: (x: 0, y: 1, z: 0))
        .animation(Animation.FlipOtherSide.flip)
    }
}

#if DEBUG
struct CardView_Previews : PreviewProvider {
    static var environment:  TypeCardEnvironment {
        let env = TypeCardEnvironment()
        env.number = "4124"
        return env
    }
    
    static var previews: some View {
        PayCardView().padding(20).environmentObject(environment)
        
    }
}
#endif
