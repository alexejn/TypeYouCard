//
//  ColoredText.swift
//  TypeYourCard
//
//  Created by alexej_ne on 25.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI
import Combine

final class ColoredTextViewModel: BindableObject {
    let didChange = PassthroughSubject<ColoredTextViewModel, Never>()
    
    private(set) var currentText: String = "ALE"
    private(set) var currentPlaceholder: String = ""
    
    private let placeholder: String
    private let showPlaceholderWhileTyping: Bool
    
    init(placeholder: String, showPlaceholderWhileTyping: Bool = false) {
        self.placeholder = placeholder
        self.showPlaceholderWhileTyping = showPlaceholderWhileTyping
        textDidRecived(text: currentText)
    }
    
    private func textDidRecived(text: String) {
        if showPlaceholderWhileTyping {
            let count = placeholder.count - text.count
            self.currentPlaceholder = String(placeholder.suffix( count > 0 ? count : 0 ))
        } else {
            self.currentPlaceholder = text.count > 0 ? "" : placeholder
        }
        self.currentText = text
        didChange.send(self)
    }
}

struct ColoredText : View {
    @ObjectBinding var model: ColoredTextViewModel
 
    var body: some View {
        HStack(spacing: 0) {
            Text(model.currentText)
            Text(model.currentPlaceholder).opacity(0.3)
        }.padding(0)
    }
}

#if DEBUG
struct ColoredText_Previews : PreviewProvider {
    static var previews: some View {
        ColoredText(model: ColoredTextViewModel(placeholder: "NAME LASTNAME"))
    }
}
#endif
