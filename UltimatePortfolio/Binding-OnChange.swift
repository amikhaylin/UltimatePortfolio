//
//  Binding-OnChange.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 25.06.2021.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
