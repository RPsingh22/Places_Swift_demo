//
//  GMPlaces_Swift_demoTests.swift
//  GMPlaces_Swift_demoTests
//
//  Created by Kanwarpal Singh on 30/01/17.
//  Copyright © 2017 Tina gupta. All rights reserved.
//

import XCTest

@testable import GMPlaces_Swift_demo

class GMPlaces_Swift_demoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchLocation() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results
        let storyboard = UIStoryboard(name: "Main" , bundle: Bundle.main)

        let searchVC = storyboard.instantiateViewController(withIdentifier: "searchView") as! SearchViewController
        
        searchVC.loadView()
        
        XCTAssertNotNil(searchVC.view, "View did not load for ViewController")
        
        searchVC.callGoogleAPI(forString: "mohali")

        let expectation = self.expectation(description: "Api should return result")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // your code here
            let  countRow:Int =  searchVC.searchResultArray.count

            if countRow == 0 {
                assertionFailure("ERROR: No location found")
                XCTFail()
            }
            else{
                expectation.fulfill()
            }
        }
    
        self.waitForExpectations(timeout: 7, handler: nil)
    }
    
    func testLocationDetailViewLoad() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results
        let storyboard = UIStoryboard(name: "Main" , bundle: Bundle.main)
        
        let searchVC = storyboard.instantiateViewController(withIdentifier: "searchView") as! SearchViewController
        
        searchVC.loadView()
        
        XCTAssertNotNil(searchVC.view, "View did not load for ViewController")
        
        searchVC.callGoogleAPI(forString: "mohali")
        
        let resultFoundExpectation = self.expectation(description: "Api should return result")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // your code here
            let  countRow:Int =  searchVC.searchResultArray.count
            
            if countRow == 0 {
                assertionFailure("ERROR: No location found")
                XCTFail()
            }
            else{
                let placeDetailVC = storyboard.instantiateViewController(withIdentifier: "detailView") as! PlaceDetailViewController
                
                let mockNavigationController = MockNavigationController(rootViewController: placeDetailVC)
                
                UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
                
                let rowToSelect = IndexPath(row: 0, section: 0);  //slecting 0th row with 0th section

                searchVC.mResultTableView.selectRow(at: rowToSelect, animated: true, scrollPosition: UITableViewScrollPosition.none);
                
                placeDetailVC.loadView()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    XCTAssertTrue(mockNavigationController.pushedViewController is PlaceDetailViewController, "PlaceDetailViewController should push")
                    resultFoundExpectation.fulfill()
                }
            }
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLocationDetailApiData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results
        
        let storyboard = UIStoryboard(name: "Main" , bundle: Bundle.main)
        
        let placeDetailVC = storyboard.instantiateViewController(withIdentifier: "detailView") as! PlaceDetailViewController
        
        placeDetailVC.loadView()
        
        XCTAssertNotNil(placeDetailVC.view, "View did not load for ViewController")
        
        placeDetailVC.callGoogleAPI(forString: "ChIJaxhMy-sIK4cRcc3Bf7EnOUI")
        
        let resultFoundExpectation = self.expectation(description: "Api should return result")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // your code here
            let  placeDetail =  placeDetailVC.placeDetail
            
            if let _ = placeDetail["name"] as? String {
                resultFoundExpectation.fulfill()

                // action is not nil, is a String type, and is now stored in actionString
            } else {
                assertionFailure("ERROR: No name found in location")
                XCTFail()
                // action was either nil, or not a String type
            }
        }
            
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
