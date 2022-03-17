//
//  DataController-Review.swift
//  UltimatePortfolioMac
//
//  Created by Andrey Mikhaylin on 17.03.2022.
//

import SwiftUI
import StoreKit

extension DataController {
    func appLaunched() {
        guard count(for: Project.fetchRequest()) >= 5 else { return }
        
//        let allScenes = NSApplication.shared.connectedScenes
//        let scene = allScenes.first { $0.activationState == .foregroundActive }
//        
//        if let windowScene = scene as? UIWindowScene {
//            SKStoreReviewController.requestReview(in: windowScene)
//        }
    }
}
