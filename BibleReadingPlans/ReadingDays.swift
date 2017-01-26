//
//  ReadingDays.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 23/01/2017.
//  Copyright © 2017 Tom Duckering. All rights reserved.
//

import Foundation

enum ReadingDays {

    case on(days: Int)
    case off(days: Int)
    case all

    func readingDays(forMonth month: Int, andYear year: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let date = Calendar.current.date(from: dateComponents)!
        return readingDays(forDay: date)
    }

    func readingDays(forDay date: Date) -> Int {
        let range = Calendar.current.range(of: .day, in: .month, for: date)!
        let numberOfDaysInMonth = range.count

        switch self {
        case .on(let daysOn):
            return min(daysOn, numberOfDaysInMonth)
        case .off(let daysOff):
            return max(numberOfDaysInMonth - daysOff, 0)
        default:
            return numberOfDaysInMonth
        }

    }
}
