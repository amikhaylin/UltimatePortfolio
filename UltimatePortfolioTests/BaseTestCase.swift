//
//  BaseTestCase.swift
//  UltimatePortfolioTests
//
//  Created by Andrey Mikhaylin on 26.07.2021.
//

import XCTest
import CoreData
@testable import UltimatePortfolio

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
