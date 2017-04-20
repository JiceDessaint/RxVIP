//
//  RxVIPUITests.swift
//  RxVIPUITests
//
//  Created by Jean-Charles DESSAINT on 19/04/2017.
//  Copyright © 2017 Jean-Charles DESSAINT. All rights reserved.
//

import XCTest


extension XCUIElement {
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}

class RxVIPUITests: XCTestCase {
    
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UseMocks"]
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimpleNavigationToDetails() {
        app.buttons["Refresh"].tap()
        
        let activity = app.activityIndicators["In progress"]
        let exists = NSPredicate(format: "visible == 0")
        
        expectation(for: exists, evaluatedWith: activity, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssert(app.tables.cells.staticTexts["Zoe Charles"].exists)
        
        app.tables.staticTexts["Zoe Charles"].tap()
        app.buttons["Close"].tap()
    }
    
    
}
