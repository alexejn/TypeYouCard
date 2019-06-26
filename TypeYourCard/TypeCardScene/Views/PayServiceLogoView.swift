//
//  PayServiceLogo.swift
//  TypeYourCard
//
//  Created by alexej_ne on 26.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

struct PayServiceLogoView : View {
    @EnvironmentObject var typeCardEnvironment: TypeCardEnvironment
    
    private var name: String {
        if let service = typeCardEnvironment.payService {
            return "\(service)"
        } else {
            return "Unknown"
        }
    }
    var body: some View {
        Text(name)
    }
}

#if DEBUG
struct PayServiceLogoView_Previews : PreviewProvider {
    static var previews: some View {
        PayServiceLogoView().environmentObject(TypeCardEnvironment())
    }
}
#endif
