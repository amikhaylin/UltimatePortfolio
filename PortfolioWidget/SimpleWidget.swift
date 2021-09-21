//
//  SimpleWidget.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 21.09.2021.
//

import WidgetKit
import SwiftUI

struct PortfolioWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Up next...")
                .font(.title)
            
            if let item = entry.items.first {
                Text(item.itemTitle)
            } else {
                Text("Nothing!")
            }
        }
    }
}

struct SimplePortfolioWidget: Widget {
    let kind: String = "SimplePortfolioWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PortfolioWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Up next…")
        .description("Your #1 top-priority item.")
        .supportedFamilies([.systemSmall])
    }
}

struct SimplePortfolioWidget_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioWidgetEntryView(entry: SimpleEntry(date: Date(), items: [Item.example]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
