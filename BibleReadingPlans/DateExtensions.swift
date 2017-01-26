//
//  DateExtensions.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 23/01/2017.
//  Copyright © 2017 Tom Duckering. All rights reserved.
//

import Foundation

extension Date {
    init?(withDay day: Int, month: Int, year: Int) {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        guard let date = Calendar.current.date(from: components)
            else { return nil }
        self = date
    }

    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
}
