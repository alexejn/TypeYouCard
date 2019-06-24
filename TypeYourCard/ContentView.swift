//
//  ContentView.swift
//  TypeYourCard
//
//  Created by Alexej Nenastev on 16.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        NavigationView {
            NavigationButton(destination: TypeYourCardScene().padding(EdgeInsets(top: -30, leading: 20, bottom: 20, trailing: 20))) {
                ZStack {
                    Color.black
                    Text("Add new card").foregroundColor(.white)
                }.cornerRadius(5)
                .frame(width: 300, height: 50, alignment: .center)
            }
        } 
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
