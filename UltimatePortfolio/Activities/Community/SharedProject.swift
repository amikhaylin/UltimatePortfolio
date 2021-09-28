//
//  SharedProject.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 27.09.2021.
//

import Foundation

struct SharedProject: Identifiable {
    let id: String
    let title: String
    let detail: String
    let owner: String
    let closed: Bool
    
    static let example = SharedProject(id: "1", title: "Example", detail: "Detail", owner: "Owner", closed: false)
}
