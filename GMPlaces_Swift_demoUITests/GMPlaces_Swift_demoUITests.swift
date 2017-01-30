//
//  GMPlaces_Swift_demoUITests.swift
//  GMPlaces_Swift_demoUITests
//
//  Created by Kanwarpal Singh on 30/01/17.
//  Copyright © 2017 Tina gupta. All rights reserved.
//

import XCTest
import UIKit

@testable import GMPlaces_Swift_demo


class GMPlaces_Swift_demoUITests: XCTestCase {
    
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
    
    func testFieldExistance() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let searchText = app.textFields["searchInputText"]
        
        if !searchText.exists {
            assertionFailure("ERROR: Enter Search String input field does not exist")
            XCTFail()
        }
        
        let searchedLocTable = app.tables["searchResultTable"]

        if !searchedLocTable.exists {
            assertionFailure("ERROR: Searched Location table does not exist")
            XCTFail()
        }
        else{
        }
    }
}
