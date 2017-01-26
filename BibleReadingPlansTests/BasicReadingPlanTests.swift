////
////  Daily_BreadTests.swift
////  BibleReadingPlans
////
////  Created by Tom Duckering on 17/12/2016.
////  Copyright © 2016 Tom Duckering. All rights reserved.
////
//
//import XCTest
//@testable import BibleReadingPlans
//
//class BasicReadingPlanTests: XCTestCase {
//    
//    var basicReadingPlan: BasicReadingPlan!
//    
//    override func setUp() {
//        super.setUp()
//        let plannedReadings = [["Matthew 1"],["Matthew 2"]]
//        
//        basicReadingPlan = BasicReadingPlan(withReadings: plannedReadings)
//        
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//    
//    func testCanCreateBasicReadingPlan() {
//        XCTAssertNotNil(basicReadingPlan)
//    }
//    
//    func testCanFetchFirstReading() {
//        if let plan = basicReadingPlan as ReadingPlan? {
//            let suggestion = plan.readings(forDate: Date(), havingStartedOn: Date())
//            XCTAssertEqual(suggestion.canTakeDayOff, false)
//            let passages = suggestion.passages
//            XCTAssertEqual(passages, ["Matthew 1"])
//        }
//    }
//    
//    func testCanFetchSecondReading() {
//        if let plan = basicReadingPlan as ReadingPlan? {
//            let yesterday = Date().daysDifference(days: -1)!
//            let suggestion = plan.readings(forDate: Date(), havingStartedOn: yesterday)
//            XCTAssertEqual(suggestion.passages, ["Matthew 2"])
//            
//        }
//    }
//    
//    func testCanCopeWhenAskedForReadingPastPlanEnd() {
//        if let plan = basicReadingPlan as ReadingPlan? {
//            let justOverAYearAgo = Date().daysDifference(days: -366)!
//            let suggestion = plan.readings(forDate: Date(), havingStartedOn: justOverAYearAgo)
//            XCTAssertEqual(suggestion.passages.count,0)
//        }
//    }
//    
//    func testCanCopeWhenAskedForReadingBeforeWeStarted() {
//        if let plan = basicReadingPlan as ReadingPlan? {
//            let tomorrow = Date().daysDifference(days: 1)!
//            let suggestion = plan.readings(forDate: Date(), havingStartedOn: tomorrow)
//            XCTAssertEqual(suggestion.passages.count,0)
//        }
//    }
//}
