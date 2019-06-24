//
//  NextButton.swift
//  TypeYourCard
//
//  Created by alexej_ne on 24.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

struct NextButton : View {
    @State var title: String = "Next"
    var body: some View {
        ButtonStyle
    }
}

#if DEBUG
struct NextButton_Previews : PreviewProvider {
    static var previews: some View {
        NextButton()
    }
}
#endif
