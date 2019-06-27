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
           
            NavigationButton(destination: TypeCardScene().padding(.top, -70)) {
                ZStack {
                    Color.black
                    Text("Add new card").foregroundColor(.white)
                }
                .cornerRadius(5)
                .frame(width: 300, height: 50, alignment: .center)
                
           }.navigationBarTitle( Text("alexejn/TypeYouCard"))
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
