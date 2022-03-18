//
//  PlatformAdjustment.swift
//  UltimatePortfolioMac
//
//  Created by Andrey Mikhaylin on 16.03.2022.
//

import SwiftUI

typealias InsetGroupedListStyle = SidebarListStyle

typealias ImageButtonStyle = BorderlessButtonStyle

extension Notification.Name {
    static let willResignActive = NSApplication.willResignActiveNotification
}

struct StackNavigationView<Content: View>: View {
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack(spacing: 0, content: content)
    }
}
