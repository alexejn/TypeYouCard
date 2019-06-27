//
//  PayServiceLogo.swift
//  TypeYourCard
//
//  Created by alexej_ne on 26.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

extension PayService {
    
    var view: some View {
        switch self {
        case .MasterCard: return MasterCardLogoView(height: 30)
        }
    }
}


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
        ZStack {
            if typeCardEnvironment.payService != nil {
               typeCardEnvironment.payService!.view
            } else {
                EmptyView().frame(height: 30)
            }

        }
    }
}

#if DEBUG
struct PayServiceLogoView_Previews : PreviewProvider {
    static var environment:  TypeCardEnvironment {
        let env = TypeCardEnvironment()
        env.number = "4124"
        return env
    }
    
    static var previews: some View {
        PayServiceLogoView().environmentObject(environment)
    }
}
#endif
