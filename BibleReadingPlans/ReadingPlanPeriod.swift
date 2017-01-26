//
//  ReadingPlanPeriod.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 23/01/2017.
//  Copyright © 2017 Tom Duckering. All rights reserved.
//

import Foundation

public struct ReadingPlanPeriod {
    let name: String
    /*let startDate: Date
     let endDate: Date*/
    let startMonth: Int
    let endMonth: Int
    let sections: [ReadingPlanSection]

    func contains(date: Date) -> Bool {
        let components = Calendar.current.dateComponents([.year], from: date)

        guard
            let year = components.year,
            let startDate = getStartDate(forYear: year),
            let endDate = getEndDate(forYear: year)
            else {
                return false
        }
        return (startDate...endDate).contains(date)
    }

    func getStartDate(forYear year: Int) -> Date? {
        return Date(withDay: 1, month: startMonth, year: year)
    }

    func getEndDate(forYear year: Int) -> Date? {
        return Date(withDay: 0, month: endMonth + 1, year: year)
    }

    func getMonths() -> [Int] {
        //Must be a better way to do this
        return Array(startMonth...endMonth)
        //return (startMonth...endMonth).filter{item in true}
    }

    func daysRemaining(fromDate date: Date, inclusive: Bool) -> Int? {
        guard
            let year = Calendar.current.dateComponents([.year], from: date).year,
            let endDate = getEndDate(forYear: year)
            else {
                return nil
        }
        let daysRemaining = endDate.days(from: date)
        if inclusive {
            return daysRemaining + 1
        } else {
            return daysRemaining
        }
    }

    func getReadings(forDate date: Date, havingAlreadyRead readingsAlreadyRead: [ReadingRecordProtocol]) -> ReadingSuggestions {

        let readingReferencesReadBeforeToday = readingsAlreadyRead.filter {
            $0.dateTimeRead < Calendar.current.startOfDay(for: date)
        }.map { $0.passageReference }

        let readingsReadToday = readingsAlreadyRead.filter {
            Calendar.current.isDate($0.dateTimeRead, inSameDayAs: date)
        }.map { $0.passageReference }

        let year = Calendar.current.dateComponents([.year], from: date).year!

        let readingsBySection = sections.map { (section: ReadingPlanSection) -> ReadingSuggestionSection in

            let unreadReadings: [String] = section.readingReferences.filter {
                !readingReferencesReadBeforeToday.contains($0)
            }

            let numberOfReadingDaysThisPeriod = getMonths().map {
                section.readingDays.readingDays(forMonth: $0, andYear: year)
            }.reduce(0, +)

            let idealReadingsPerDayThisPeriod = Double(section.readingReferences.count) / Double(numberOfReadingDaysThisPeriod)
            let integerIdealdReadingsPerDayThisPeriod = Int(ceil(idealReadingsPerDayThisPeriod))

            let numberOfReadingsRemaining = unreadReadings.count

            let numberOfDaysLeftInPeriod = daysRemaining(fromDate: date, inclusive: true)!

            let numberOfReadingsPerDayToComplete = Double(numberOfReadingsRemaining) / Double(numberOfDaysLeftInPeriod)

            let integerNumberOfReadingsPerDayToComplete = Int(ceil(numberOfReadingsPerDayToComplete))

            let numberOfReadingsToday = max(integerIdealdReadingsPerDayThisPeriod, integerNumberOfReadingsPerDayToComplete)

            let readings = Array(unreadReadings.prefix(numberOfReadingsToday))

            let readingSuggestions: [ReadingSuggestion] = readings.map { readingReference in
                let hasBeenRead = readingsReadToday.contains(readingReference)
                return ReadingSuggestion(readingReference: readingReference, hasBeenRead: hasBeenRead)
            }

            return ReadingSuggestionSection(name: section.name, readings: readingSuggestions)
        }
        return readingsBySection
    }

    func getReadings(havingAlreadyRead readingsAlreadyRead: [ReadingRecordProtocol]) -> [ReadingSuggestion] {

        let readingReferencesThatHaveBeenRead = readingsAlreadyRead.map { $0.passageReference }

        let allReadingsForThisPeriod = sections.flatMap { $0.readingReferences }

        let allReadingsAsReadingSuggestions = allReadingsForThisPeriod.map { (readingReference: String) -> ReadingSuggestion in
            let readingHasBeenRead = readingReferencesThatHaveBeenRead.contains(readingReference)
            return ReadingSuggestion(readingReference: readingReference, hasBeenRead: readingHasBeenRead)
        }

        return allReadingsAsReadingSuggestions
    }

    func getMonthIndex(forDate date: Date) -> Int? {
        let components = Calendar.current.dateComponents([.month], from: date)
        return getMonths().index(of: components.month!)
    }
}
