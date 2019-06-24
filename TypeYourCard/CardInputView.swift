//
//  CardInputView.swift
//  TypeYourCard
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI


struct CardInputView : View {
    @EnvironmentObject var payCard: PayCard
    var field: PayCardInputField
    
    var body: some View {
        IDView(content, id: field.title)
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(field.title)
                .font(.system(size: 15))
                //.fontWeight(.light)
                .opacity(0.5)
            
            TextField($payCard.cvc)
                .frame(height: 60)
                .border(Color.black, width: 0.3, cornerRadius: 10)
            
        }
    }
}


#if DEBUG
struct CardInputView_Previews : PreviewProvider {
    static var previews: some View {
        CardInputView(field: PayCardInputField.all.first!).padding(20)
    }
}
#endif
