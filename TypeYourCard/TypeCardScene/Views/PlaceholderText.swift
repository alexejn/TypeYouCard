//
//  PlaceholderText.swift
//  TypeYourCard
//
//  Created by alexej_ne on 25.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI
import Combine

struct PlaceholderText : View {
 
    private let placeholder: String
    private let text: String
    
    init(placeholder: String, text: String, showPlaceholderWhileTyping: Bool = true) {
        if showPlaceholderWhileTyping {
            let count = placeholder.count - text.count
            self.placeholder = String(placeholder.suffix( count > 0 ? count : 0 ))
        } else {
            self.placeholder = text.count > 0 ? "" : placeholder
        }
        self.text = text
        print("TEXT ", text)
        print("placeholder ", placeholder)
    }
    
    
    var body: some View {
        HStack(spacing: 0) {
            Text(text)
            Text(placeholder)
                .opacity(0.3)
        }.padding(0)
        .animation(nil)
    }
}


#if DEBUG
struct PlaceholderText_Previews : PreviewProvider {
    static var previews: some View {
        PlaceholderText(placeholder: "NAME LASTNAME", text: "ALEX")
    }
}
#endif
