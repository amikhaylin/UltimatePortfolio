//
//  UltimatePortfolioTests.swift
//  UltimatePortfolioTests
//
//  Created by Andrey Mikhaylin on 23.07.2021.
//

import CoreData
import XCTest
@testable import UltimatePortfolio

class BaseTextCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
