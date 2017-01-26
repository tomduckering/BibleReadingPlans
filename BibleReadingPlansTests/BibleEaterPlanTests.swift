//
//  BibleEaterPlanTests.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 27/12/2016.
//  Copyright © 2016 Tom Duckering. All rights reserved.
//

import XCTest
@testable import BibleReadingPlans

enum BibleEaterPlanTestError: Error {
    case problemsLoadingJSONFromBundle
}

class BibleEaterPlanTests: XCTestCase {

    let bundle = Bundle.init(for: BibleEaterPlanTests.self)

    func testWeCanLoadBibleEaterPlanFromBundle() {
        guard let bibleEaterPlan = BibleEaterPlan(fromBundle: bundle, withName: "bibleeater")
            else {
                XCTFail("Couldn't initialise plan from JSON from the bundle")
                return
        }
        XCTAssertEqual(bibleEaterPlan.name, "Bible Eater")
    }

    func testWeCanGetCurrentReadingPeriod() {
        guard let bibleEaterPlan = BibleEaterPlan(fromBundle: bundle, withName: "bibleeater")
            else {
                XCTFail("Couldn't initialise plan from JSON from the bundle")
                return
        }

        let testReadingDate = Date(withDay: 1, month: 1, year: 2016)!

        guard let currentPeriod = bibleEaterPlan.getPeriod(forDate: testReadingDate)
            else {
                XCTFail("Unable to get current period - expect to be able to")
                return
        }

        XCTAssertEqual(currentPeriod.name, "Q1")
    }

    func testSuggestsReadingsBySection() {
        guard let bibleEaterPlan = BibleEaterPlan(fromBundle: bundle, withName: "bibleeater")
            else {
                XCTFail("Couldn't initialise plan from JSON from the bundle")
                return
        }

        let testReadingDate = Date(withDay: 1, month: 1, year: 2016)!

        let suggestedReadings = bibleEaterPlan.getReadings(forDate: testReadingDate, havingAlreadyRead: [])

        XCTAssertEqual(suggestedReadings?.count, 3)

    }

    func testSuggestsReadingsEvenIfWeReadThemToday() {
        guard let bibleEaterPlan = BibleEaterPlan(fromBundle: bundle, withName: "bibleeater")
            else {
                XCTFail("Couldn't initialise plan from JSON from the bundle")
                return
        }

        let testReadingDate = Date(withDay: 1, month: 1, year: 2016)!

        var readingHistory = [FakeReadingRecord]()
        readingHistory.append(FakeReadingRecord(passageReference: "Genesis 1", dateTimeRead: Date(withDay: 1, month: 1, year: 2016)!))

        guard
            let suggestedReadings = bibleEaterPlan.getReadings(forDate: testReadingDate, havingAlreadyRead: readingHistory)
            else {
                XCTFail("Got no suggested readings at all!")
                return
        }

        let OTReadings = suggestedReadings[2].readings.map { $0.readingReference }

        XCTAssertTrue(OTReadings.contains("Genesis 1"))
        XCTAssertTrue(OTReadings.contains("Genesis 2"))
    }

    func testDoesNotSuggestsReadingsIfWeReadThemYesterday() {
        guard let bibleEaterPlan = BibleEaterPlan(fromBundle: bundle, withName: "bibleeater")
            else {
                XCTFail("Couldn't initialise plan from JSON from the bundle")
                return
        }

        let testReadingDate = Date(withDay: 2, month: 1, year: 2016)!

        var readingHistory = [FakeReadingRecord]()
        readingHistory.append(FakeReadingRecord(passageReference: "Genesis 1", dateTimeRead: Date(withDay: 1, month: 1, year: 2016)!))

        guard
            let suggestedReadings = bibleEaterPlan.getReadings(forDate: testReadingDate, havingAlreadyRead: readingHistory)
            else {
                XCTFail("Got no suggested readings at all!")
                return
        }

        let OTReadings = suggestedReadings[2].readings.map { $0.readingReference }
        XCTAssertFalse(OTReadings.contains("Genesis 1"))

    }

    func testSuggestsTheNextDaysReadingsWhenIHaveReadTheFirstSet() {
        guard let bibleEaterPlan = BibleEaterPlan(fromBundle: bundle, withName: "bibleeater")
            else {
                XCTFail("Couldn't initialise plan from JSON from the bundle")
                return
        }

        let testReadingDate = Date(withDay: 2, month: 1, year: 2016)!

        var readingHistory = [FakeReadingRecord]()
        readingHistory.append(FakeReadingRecord(passageReference: "Genesis 1", dateTimeRead: Date(withDay: 1, month: 1, year: 2016)!))
        readingHistory.append(FakeReadingRecord(passageReference: "Genesis 2", dateTimeRead: Date(withDay: 1, month: 1, year: 2016)!))
        readingHistory.append(FakeReadingRecord(passageReference: "Matthew 1", dateTimeRead: Date(withDay: 1, month: 1, year: 2016)!))

        guard
            let suggestedReadings = bibleEaterPlan.getReadings(forDate: testReadingDate, havingAlreadyRead: readingHistory)
            else {
                XCTFail("Got no suggested readings at all!")
                return
        }

        let OTReadings = suggestedReadings[2].readings.map { $0.readingReference }
        let NTReadings = suggestedReadings[0].readings.map { $0.readingReference }

        XCTAssertTrue(OTReadings.contains("Genesis 3"))
        XCTAssertTrue(OTReadings.contains("Genesis 4"))
        XCTAssertTrue(NTReadings.contains("Matthew 2"))
    }

    func testSuggestsTheNextDaysReadingsWhenIHaveReadTheFirstSetAndSkipADay() {
        guard let bibleEaterPlan = BibleEaterPlan(fromBundle: bundle, withName: "bibleeater")
            else {
                XCTFail("Couldn't initialise plan from JSON from the bundle")
                return
        }

        let testReadingDate = Date(withDay: 3, month: 1, year: 2016)!

        var readingHistory = [FakeReadingRecord]()
        readingHistory.append(FakeReadingRecord(passageReference: "Genesis 1", dateTimeRead: Date(withDay: 1, month: 1, year: 2016)!))
        readingHistory.append(FakeReadingRecord(passageReference: "Genesis 2", dateTimeRead: Date(withDay: 1, month: 1, year: 2016)!))
        readingHistory.append(FakeReadingRecord(passageReference: "Matthew 1", dateTimeRead: Date(withDay: 1, month: 1, year: 2016)!))

        guard
            let suggestedReadings = bibleEaterPlan.getReadings(forDate: testReadingDate, havingAlreadyRead: readingHistory)
            else {
                XCTFail("Got no suggested readings at all!")
                return
        }

        let OTReadings = suggestedReadings[2].readings.map { $0.readingReference }
        let NTReadings = suggestedReadings[0].readings.map { $0.readingReference }

        XCTAssertTrue(OTReadings.contains("Genesis 3"))
        XCTAssertTrue(OTReadings.contains("Genesis 4"))
        XCTAssertTrue(NTReadings.contains("Matthew 2"))
    }

    func testSuggestsFirstDaysReadingsWhenISkipTheFirstDay() {
        guard let bibleEaterPlan = BibleEaterPlan(fromBundle: bundle, withName: "bibleeater")
            else {
                XCTFail("Couldn't initialise plan from JSON from the bundle")
                return
        }

        let testReadingDate = Date(withDay: 2, month: 1, year: 2016)!

        let readingHistory = [FakeReadingRecord]()

        guard
            let suggestedReadings = bibleEaterPlan.getReadings(forDate: testReadingDate, havingAlreadyRead: readingHistory)
            else {
                XCTFail("Got no suggested readings at all!")
                return
        }

        let OTReadings = suggestedReadings[2].readings.map { $0.readingReference }
        let NTReadings = suggestedReadings[0].readings.map { $0.readingReference }

        XCTAssertTrue(OTReadings.contains("Genesis 1"))
        XCTAssertTrue(OTReadings.contains("Genesis 2"))
        XCTAssertTrue(NTReadings.contains("Matthew 1"))
    }

    func testSuggestsTheRightNumberOfReadingsPerSection() {
        guard let bibleEaterPlan = BibleEaterPlan(fromBundle: bundle, withName: "bibleeater")
            else {
                XCTFail("Couldn't initialise plan from JSON from the bundle")
                return
        }

        let testReadingDate = Date(withDay: 2, month: 1, year: 2016)!

        let readingHistory = [FakeReadingRecord]()

        guard
            let suggestedReadings = bibleEaterPlan.getReadings(forDate: testReadingDate, havingAlreadyRead: readingHistory)
            else {
                XCTFail("Got no suggested readings at all!")
                return
        }

        let WholeBookReadings = suggestedReadings[1].readings.map { $0.readingReference }
        let OTReadings = suggestedReadings[2].readings.map { $0.readingReference }
        let NTReadings = suggestedReadings[0].readings.map { $0.readingReference }

        XCTAssertEqual(OTReadings.count, 2)
        XCTAssertEqual(NTReadings.count, 1)
        XCTAssertEqual(WholeBookReadings.count, 1)

    }

    func testSuggestionsDontHaveSectionsWithNoReadings() {
        guard let bibleEaterPlan = BibleEaterPlan(fromBundle: bundle, withName: "bibleeater")
            else {
                XCTFail("Couldn't initialise plan from JSON from the bundle")
                return
        }

        let testReadingDate = Date(withDay: 3, month: 1, year: 2016)!

        var readingHistory = [FakeReadingRecord]()
        readingHistory.append(FakeReadingRecord(passageReference: "Deuteronomy", dateTimeRead: Date(withDay: 1, month: 1, year: 2016)!))

        guard
            let suggestedReadings = bibleEaterPlan.getReadings(forDate: testReadingDate, havingAlreadyRead: readingHistory)
            else {
                XCTFail("Got no suggested readings at all!")
                return
        }
        XCTAssertEqual(suggestedReadings.count, 2)
    }

    func testSuggestionsShowReadingsThatWeReadTodayButShowThatWeReadThem() {
        guard let bibleEaterPlan = BibleEaterPlan(fromBundle: bundle, withName: "bibleeater")
            else {
                XCTFail("Couldn't initialise plan from JSON from the bundle")
                return
        }

        let testReadingDate = Date(withDay: 1, month: 1, year: 2016)!
        var readingHistory = [FakeReadingRecord]()
        readingHistory.append(FakeReadingRecord(passageReference: "Deuteronomy", dateTimeRead: Date(withDay: 1, month: 1, year: 2016)!))
        readingHistory.append(FakeReadingRecord(passageReference: "Genesis 2", dateTimeRead: Date(withDay: 1, month: 1, year: 2016)!))
        readingHistory.append(FakeReadingRecord(passageReference: "Matthew 1", dateTimeRead: Date(withDay: 1, month: 1, year: 2016)!))

        guard
            let suggestedReadings = bibleEaterPlan.getReadings(forDate: testReadingDate, havingAlreadyRead: readingHistory)
            else {
                XCTFail("Got no suggested readings at all!")
                return
        }

        let NTReadings = suggestedReadings[0].readings

        let expectedReadingSuggestion = ReadingSuggestion(readingReference: "Matthew 1", hasBeenRead: true)

        XCTAssertEqual(NTReadings[0], expectedReadingSuggestion)
    }

    func testCanGetAllReadingsInOrder() {
        guard let bibleEaterPlan = BibleEaterPlan(fromBundle: bundle, withName: "bibleeater")
            else {
                XCTFail("Couldn't initialise plan from JSON from the bundle")
                return
        }

        let allReadings = bibleEaterPlan.getReadings()

        XCTAssertTrue(allReadings.count > 365)
    }

}
