//
//  CardInputView.swift
//  TypeYourCard
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI


struct CardInputView : View {
    @State var text: String = ""
    let title: String
    
    var body: some View {
        IDView(content, id: title)
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 15))
                //.fontWeight(.light)
                .opacity(0.5)
            
            TextField($text)
                .frame(height: 60)
                .border(Color.black, width: 0.3, cornerRadius: 10)
        }
    }
}


#if DEBUG
struct CardInputView_Previews : PreviewProvider {
    static var previews: some View {
        CardInputView(title: "Cardholder Name").padding(20)
    }
}
#endif
