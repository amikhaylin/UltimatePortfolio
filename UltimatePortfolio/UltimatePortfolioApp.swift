//
//  UltimatePortfolioApp.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 16.06.2021.
//

import SwiftUI

@main
struct UltimatePortfolioApp: App {
    @StateObject var dataController: DataController
    @StateObject var unlockManager: UnlockManager
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .environmentObject(unlockManager)
                // Automatically save when we detect that we are
                // no longer the foreground app. Use this rather than
                // scene phase so we can port to macOS, where scene
                // phase won't detect our app losing focus.
                .onReceive(
                    NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification),
                    perform: save
                )
                .onAppear(perform: dataController.appLaunched)
        }
    }
    
    init() {
        let dataController = DataController()
        let unlockManager = UnlockManager(dataController: dataController)
        
        _dataController = StateObject(wrappedValue: dataController)
        _unlockManager = StateObject(wrappedValue: unlockManager)
    }
    
    func save(_ note: Notification) {
        dataController.save()
    }
}
