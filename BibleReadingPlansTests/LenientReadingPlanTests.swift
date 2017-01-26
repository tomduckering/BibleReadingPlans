//
//  LenientReadingPlanTests.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 22/12/2016.
//  Copyright © 2016 Tom Duckering. All rights reserved.
//

import XCTest
@testable import BibleReadingPlans

//class LenientReadingPlanTests: XCTestCase {
//    
//    var lenientReadingPlan: LenientReadingPlan!
//    
//    override func setUp() {
//        super.setUp()
//        let plannedReadings = [[["Matthew 1"],["Matthew 2"]]]
//        
//        lenientReadingPlan = LenientReadingPlan(withReadings: plannedReadings)
//        
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//    
//    func testCanCreateBasicReadingPlan() {
//        XCTAssertNotNil(lenientReadingPlan)
//    }
//    
//    func testCanFetchFirstDaysReadings() {
//        if let plan = lenientReadingPlan as ReadingPlan? {
//                        
//            let firstDayOfJanuary = Date(withDay: 1, month: 1, year:2017)!
//            
//            let suggestion = plan.readings(forDate: firstDayOfJanuary, havingStartedOn: firstDayOfJanuary)
//            
//            XCTAssertEqual(suggestion.canTakeDayOff, false)
//            XCTAssertEqual(suggestion.passages, ["Matthew 1"])
//        }
//    }
//}
