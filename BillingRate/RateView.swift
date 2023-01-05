//
//  RateView.swift
//  BillingRate
//
//  Created by Mohammad Azam on 1/4/23.
//

import SwiftUI

struct RateView: View {
    
    let title: String
    let rate: Double
    
    var body: some View {
        VStack {
            Text(rate, format: .currency(code: Locale.currencyCode))
                .font(.largeTitle)
            Text(title)
                .opacity(0.5)
        }
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView(title: "Hourly", rate: 150)
    }
}
