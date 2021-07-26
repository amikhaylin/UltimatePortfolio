//
//  AssetTests.swift
//  UltimatePortfolioTests
//
//  Created by Andrey Mikhaylin on 23.07.2021.
//

import XCTest
@testable import UltimatePortfolio

class AssetTests: XCTestCase {

    func testColorsExist() {
        for color in Project.colors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load color '\(color)' from asset catalog.")
        }
    }
    
    func testJSONLoadCorrectly() {
        XCTAssertTrue(Award.allAwards.isEmpty == false, "Failed to load awards from JSON.")
    }
}
