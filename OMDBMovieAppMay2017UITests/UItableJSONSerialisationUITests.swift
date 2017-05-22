//
//  UItableJSONSerialisationUITests.swift
//  UItableJSONSerialisationUITests
//
//  Created by Ben Smith on 19/01/17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import XCTest

class UItableJSONSerialisationUITests: XCTestCase {
        
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
    
    func testTypingJaws() {
        
        
        let app = XCUIApplication()
        app.tables.buttons["Movie"].tap()
        app.searchFields["Search"].tap()
        
        let aKey = app.keys["a"]
        aKey.tap()
        aKey.tap()
        app.keys["w"].tap()
        app.typeText("Jaw")
        
        let element = app.otherElements.containing(.navigationBar, identifier:"UIView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        app.typeText("s")
        element.tap()
        app.typeText("\n")
        element.press(forDuration: 0.3);
        app.navigationBars["UIView"].buttons["Root View Controller"].tap()
        
        

    }
    
}
