//
//  CloudError.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 04.10.2021.
//

import Foundation

struct CloudError: Identifiable, ExpressibleByStringInterpolation {
    var id: String { message }
    var message: String
    
    init(stringLiteral value: String) {
        self.message = value
    }
}
