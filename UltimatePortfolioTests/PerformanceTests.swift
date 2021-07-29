//
//  PerformanceTests.swift
//  UltimatePortfolioTests
//
//  Created by Andrey Mikhaylin on 29.07.2021.
//

import XCTest
@testable import UltimatePortfolio

class PerformanceTests: BaseTestCase {
    func testAwardCalculationPerformance() throws {
        // Run creating sample data 100 times
        for _ in 1...100 {
            try dataController.createSampleData()
        }
        
        let awards = Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(awards.count, 500, "This checks the awards count is constant")
        
        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }
}
