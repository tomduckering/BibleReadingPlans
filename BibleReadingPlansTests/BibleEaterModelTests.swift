//
//  BibleEaterModelTests.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 28/12/2016.
//  Copyright © 2016 Tom Duckering. All rights reserved.
//

import XCTest
@testable import BibleReadingPlans

class BibleEaterModelTests: XCTestCase {

    func testGivesStartDate() {
        let testPeriod = ReadingPlanPeriod(name: "test", startMonth: 1, endMonth: 3, sections: [])

        let startDate = testPeriod.getStartDate(forYear: 2016)

        XCTAssertEqual(startDate, Date(withDay: 1, month: 1, year: 2016))
    }

    func testGivesEndDate() {
        let testPeriod = ReadingPlanPeriod(name: "test", startMonth: 1, endMonth: 3, sections: [])

        let endDate = testPeriod.getEndDate(forYear: 2016)

        XCTAssertEqual(endDate, Date(withDay: 31, month: 3, year: 2016))
    }

    func testGivesEndDateForEndOfYear() {
        let testPeriod = ReadingPlanPeriod(name: "test", startMonth: 1, endMonth: 12, sections: [])

        let endDate = testPeriod.getEndDate(forYear: 2016)

        XCTAssertEqual(endDate, Date(withDay: 31, month: 12, year: 2016))
    }

    func testCanTellIfContainsDate() {
        let testPeriod = ReadingPlanPeriod(name: "test", startMonth: 1, endMonth: 3, sections: [])

        let testDate = Date(withDay: 1, month: 2, year: 2016)!

        let isInPeriod = testPeriod.contains(date: testDate)

        XCTAssertTrue(isInPeriod)
    }

    func testCanTellIfDoesNotContainDate() {
        let testPeriod = ReadingPlanPeriod(name: "test", startMonth: 1, endMonth: 3, sections: [])

        let testDate = Date(withDay: 1, month: 4, year: 2016)!

        let isInPeriod = testPeriod.contains(date: testDate)

        XCTAssertFalse(isInPeriod)
    }

    func testCanGetMonthsInPeriod() {
        let testPeriod = ReadingPlanPeriod(name: "test", startMonth: 1, endMonth: 3, sections:[])

        let expectedMonths = [1, 2, 3]

        let months = testPeriod.getMonths()

        XCTAssertEqual(months, expectedMonths)
    }

    func testCanGetMonthIndexForCurrentPeriod() {
        let testPeriod = ReadingPlanPeriod(name: "test", startMonth: 10, endMonth: 12, sections:[])

        let testDate = Date(withDay: 1, month: 11, year: 2016)!

        let expectedMonthIndex = 1

        let monthIndex = testPeriod.getMonthIndex(forDate: testDate)

        XCTAssertEqual(monthIndex, expectedMonthIndex)
    }

    func testCanGetDaysLeftInPeriod() {
        let testPeriod = ReadingPlanPeriod(name: "test", startMonth: 10, endMonth: 12, sections:[])
        let testDate = Date(withDay: 1, month: 11, year: 2016)!

        let expectedDaysRemaining = 30 + 31

        let daysRemaining = testPeriod.daysRemaining(fromDate: testDate, inclusive: true)

        XCTAssertEqual(daysRemaining, expectedDaysRemaining)
    }
}
