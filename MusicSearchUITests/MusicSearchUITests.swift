//
//  MusicSearchUITests.swift
//  MusicSearchUITests
//
//  Created by Personal on 9/26/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import XCTest

class MusicSearchUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTableViewOnLoad() {
        
        // Test Before Search
        let app = XCUIApplication()
        let tableView = app.tables["tableView"]
        XCTAssertTrue(tableView.cells.count == 0)
    
    }
    
    func testSearchBarSearch() {
        
        // Add Text Into SearchBar
        let app = XCUIApplication()
        let searchBar = app.searchFields.element(boundBy: 0)
        searchBar.tap()
        searchBar.typeText("Y")
        
        XCTAssertTrue(searchBar.value as! String == "Y")

        
    }
    
    // MARK: - TODO: (with more time & a little more experience with automation) Tests that Handle Checking Data After
    // SearchBar text changes and API Call to get songs is trigged
    // Test Number of Cells in TableView, Click on Cell, Push New View,
    // Pop View, etc

}
