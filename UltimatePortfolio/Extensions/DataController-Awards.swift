//
//  DataController-Awards.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 15.09.2021.
//

import CoreData

extension DataController {
    func hasEarned(award: Award) -> Bool {
        switch award.criterion {
        case "items":
            let fetchRequest: NSFetchRequest<Item> = NSFetchRequest(entityName: "Item")
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
        case "complete":
            let fetchRequest: NSFetchRequest<Item> = NSFetchRequest(entityName: "Item")
            fetchRequest.predicate = NSPredicate(format: "completed = true")
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
        case "chat":
            return UserDefaults.standard.integer(forKey: "chatCount") >= award.value
        default:
            // FIXME: fatalError("Unknown award criterion \(award.criterion).")
            return false
        }
    }
}
