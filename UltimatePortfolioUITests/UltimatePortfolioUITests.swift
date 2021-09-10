//
//  UltimatePortfolioUITests.swift
//  UltimatePortfolioUITests
//
//  Created by Andrey Mikhaylin on 30.07.2021.
//

import XCTest

class UltimatePortfolioUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    func testAppHas4Tabs() throws {
        XCTAssertEqual(app.tabBars.buttons.count, 4, "There should be 4 tabs")
    }
    
    func testOpenProjectTabAddsProjects() {
        app.buttons["Open"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially")
        
        for tapCount in 1...3 {
            app.buttons["add"].tap()
            XCTAssertEqual(app.tables.cells.count, tapCount, "There should be \(tapCount) row(s)")
        }
    }
    
    func testAddingItemInsertsRows() {
        app.buttons["Open"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially")
        
        app.buttons["add"].tap()
        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 row (project)")
        
        app.buttons["Add New Item"].tap()
        XCTAssertEqual(app.tables.cells.count, 2, "There should be 2 rows - project and item")
    }
    
    func testEditingProjectUpdatesCorrectly() {
        app.buttons["Open"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially")
        
        app.buttons["add"].tap()
        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 row (project)")
        
        app.buttons["NEW PROJECT"].tap()
        app.textFields["Project name"].tap()
        app.textFields["Project name"].typeText(" 2")
        
//        app.keys["space"].tap()
//        app.keys["more"].tap()
//        app.keys["2"].tap()
//        app.buttons["Return"].tap()
        
        app.buttons["Open Projects"].tap()
        XCTAssertTrue(app.buttons["NEW PROJECT 2"].exists, "The new project name should be visible in the list")
    }
    
    func testEditingItemUpdatesCorrectly() {
        // Go to Open Projects and add one project and one item.
        testAddingItemInsertsRows()
        
        app.buttons["New Item"].tap()
        
        app.textFields["Item name"].tap()
        app.textFields["Item name"].typeText(" 2")
//        app.keys["space"].tap()
//        app.keys["more"].tap()
//        app.keys["2"].tap()
//        app.buttons["Return"].tap()
        
        app.buttons["Open Projects"].tap()
        XCTAssertTrue(app.buttons["New Item 2"].exists, "The new item name should be visible in the list")
    }
    
    func testAllAwardsShowLockedAlert() {
        app.buttons["Awards"].tap()
        
        for award in app.scrollViews.buttons.allElementsBoundByIndex {
            award.tap()
            XCTAssertTrue(app.alerts["Locked"].exists, "There should be a Locked alert showing for award")
            app.buttons["OK"].tap()
        }
    }
    
    func testOpeningAndClosingProjectsMovesThemBetweenTabs() {
        // Go to Open Projects and add one project and one item.
        testAddingItemInsertsRows()
        
        app.buttons["NEW PROJECT"].tap()
        app.buttons["Close this project"].tap()
        
        // Move back
        app.buttons["Open Projects"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "Project should be moved to Closed tab")
        
        // Move to closed
        app.buttons["Closed"].tap()
        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 project with 1 item in Closed tab")
        
        // Reopen project
        app.buttons["NEW PROJECT"].tap()
        app.buttons["Reopen this project"].tap()
        
        // Move back
        app.buttons["Closed Projects"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "Project should be moved to Open tab")
        
        // Move to open
        app.buttons["Open"].tap()
        XCTAssertEqual(app.tables.cells.count, 2, "There should be 1 project with 1 item in Open tab")
    }
    
    func testSwipeToDelete() {
        // Go to Open Projects and add one project and one item.
        testAddingItemInsertsRows()
        
        app.buttons["New Item"].swipeLeft()
        app.buttons["Delete"].tap()
        XCTAssertEqual(app.tables.cells.count, 1, "There should leave only 1 project row")
    }
    
    func testDeleteProjectFromUI() {
        // Go to Open Projects and add one project and one item.
        testAddingItemInsertsRows()
        
        app.buttons["NEW PROJECT"].tap()
        app.buttons["Delete this project"].tap()
        
        app.alerts["Delete project?"].buttons["Delete"].tap()
        app.buttons["Open"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "There should be 0 projects in Open tab")
    }
}
