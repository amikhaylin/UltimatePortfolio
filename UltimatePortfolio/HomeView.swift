//
//  HomeView.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 18.06.2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataController: DataController
    static let tag: String? = "Home"
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Add Data") {
                    dataController.deleteAll()
                    try? dataController.createSampleData()
                }
            }
            .navigationBarTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
