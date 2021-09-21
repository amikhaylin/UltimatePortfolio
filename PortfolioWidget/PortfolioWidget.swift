//
//  PortfolioWidget.swift
//  PortfolioWidget
//
//  Created by Andrey Mikhaylin on 15.09.2021.
//

import WidgetKit
import SwiftUI

@main
struct PortfolioWidgets: WidgetBundle {
    var body: some Widget {
        SimplePortfolioWidget()
        ComplexPortfolioWidget()
    }
}
