//
//  Locale+Extensions.swift
//  BillingRate
//
//  Created by Mohammad Azam on 1/4/23.
//

import Foundation

extension Locale {
    
    static var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
}
