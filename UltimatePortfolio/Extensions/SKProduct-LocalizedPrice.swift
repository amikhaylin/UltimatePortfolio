//
//  SKProduct-LocalizedPrice.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 22.08.2021.
//

import StoreKit

extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}
