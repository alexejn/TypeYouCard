//
//  CardView.swift
//  TypeYourCard
//
//  Created by Alexej Nenastev on 16.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

struct CardView : View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("LOGO")
            }
            Spacer()
            Spacer()
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
            }.foregroundColor(.white).opacity(0.6)
            
            
        }
            .padding(20)
            
        //.aspectRatio(2, contentMode: .fill)
        .frame(width: 340, height: 212, alignment: .center)
        .background(Color(red: 59/255, green: 58/255, blue: 61/255), cornerRadius: 20)
        
    }
}

#if DEBUG
struct CardView_Previews : PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
#endif
