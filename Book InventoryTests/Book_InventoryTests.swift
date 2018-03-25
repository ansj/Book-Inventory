//
//  Book_InventoryTests.swift
//  Book InventoryTests
//
//  Created by Ananta Sjartuni on 22/3/18.
//  Copyright © 2018 Sjartuni. All rights reserved.
//

import XCTest
@testable import Book_Inventory

class Book_InventoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let dbHandling = PersistHandling()
        let result = dbHandling.AddRecord("Book Title", publisher: "Book Publisher", author: "Book author", publish_date: "12-mar-2018")
        
        if result {
            let results = dbHandling.getRecords()
            print(results)
        }
    }
    
    func testAPIPSI() {
        let api = ApiHandling()
        
        // Declare our expectation
        let readyExpectation = expectation(description: "ready")
        
        api.getAPI(apiURLType.PSI_URL) { (result, err) in
            print(result)
            XCTAssertTrue((result != nil), "get data finish")
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
            }
        // Loop until the expectation is fulfilled
        waitForExpectations(timeout: 5, handler: { error in
            XCTAssertNil(error, "Error")
        })
        
    }

    func testAPIPM25() {
        let api = ApiHandling()
        
        // Declare our expectation
        let readyExpectation = expectation(description: "ready")
        
        api.getAPI(apiURLType.PM_URL) { (result, err) in
            print(result)
            XCTAssertTrue((result != nil), "get data finish")
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
        }
        // Loop until the expectation is fulfilled
        waitForExpectations(timeout: 5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    func testAPIWeather() {
        let api = ApiHandling()
        
        // Declare our expectation
        let readyExpectation = expectation(description: "ready")
        
        api.getAPI(apiURLType.WEATHER_URL) { (result, err) in
            print(result)
            XCTAssertTrue((result != nil), "get data finish")
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
        }
        // Loop until the expectation is fulfilled
        waitForExpectations(timeout: 5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
