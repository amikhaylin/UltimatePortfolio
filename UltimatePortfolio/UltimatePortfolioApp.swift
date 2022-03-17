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
    
    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .environmentObject(unlockManager)
                .onReceive(
                    NotificationCenter.default.publisher(for: .willResignActive),
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
        
        #if targetEnvironment(simulator)
        UserDefaults.standard.set("amikhaylin", forKey: "username")
        #endif
    }
    
    func save(_ note: Notification) {
        dataController.save()
    }
}
