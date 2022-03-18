//
//  PlatformAdjustments.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 16.03.2022.
//

import SwiftUI

typealias ImageButtonStyle = BorderlessButtonStyle

extension Notification.Name {
    static let willResignActive = UIApplication.willResignActiveNotification
}

struct StackNavigationView<Content: View>: View {
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        NavigationView(content: content)
            .navigationViewStyle(.stack)
    }
}
