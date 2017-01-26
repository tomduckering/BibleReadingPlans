//
//  ReadingHistoryTests.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 22/12/2016.
//  Copyright © 2016 Tom Duckering. All rights reserved.
//

import XCTest
@testable import BibleReadingPlans

class ReadingHistoryTests: XCTestCase {

    let now = Date()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreationOfReadingRecords() {

        let readingRecord = FakeReadingRecord(passageReference: "Some Reference", dateTimeRead: now)

        XCTAssertEqual(readingRecord.passageReference, "Some Reference")
        XCTAssertEqual(readingRecord.dateTimeRead, now)
    }

//    func testCalculationOfMissedDays() {
//        let startDate = now.daysDifference(days: -2)!
//        let readingRecordForFirstDay = FakeReadingRecord(passageReference: "Some Reference", dateTimeRead: startDate)
//      
//        let missedDates = datesMissed(forReadingRecords:[readingRecordForFirstDay],since: startDate, until: now)
//        
//        XCTAssertEqual(missedDates.count, 2)
//    }
}
