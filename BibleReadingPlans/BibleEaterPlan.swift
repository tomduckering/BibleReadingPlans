//
//  BibleEaterPlan.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 27/12/2016.
//  Copyright © 2017 Tom Duckering. All rights reserved.
//

import Foundation

public typealias ReadingSuggestions = [ReadingSuggestionSection]

/// Grounds reading suggestions by type
public struct ReadingSuggestionSection {
    public let name: String
    public let readings: [ReadingSuggestion]
}

public struct BibleEaterPlan {
    public let name: String
    public let periods: [ReadingPlanPeriod]

    public func getPeriod(forDate date: Date) -> ReadingPlanPeriod? {
        return periods.first(where: { $0.contains(date: date) })
    }

    public func getReadings(forDate date: Date, havingAlreadyRead readingsAlreadyRead: [ReadingRecordProtocol]) -> ReadingSuggestions? {
        guard let period = getPeriod(forDate: date)
            else {
                return nil
        }

        return period.getReadings(forDate: date, havingAlreadyRead: readingsAlreadyRead).filter { section in
            !section.readings.isEmpty
        }
    }

    public func getReadings(havingAlreadyRead readingsAlreadyRead: [ReadingRecordProtocol] = []) -> [ReadingSuggestion] {
        return periods.flatMap { $0.getReadings(havingAlreadyRead: readingsAlreadyRead) }
    }
}
