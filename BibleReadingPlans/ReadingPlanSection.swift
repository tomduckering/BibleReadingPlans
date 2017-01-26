//
//  ReadingPlanSection.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 23/01/2017.
//  Copyright © 2017 Tom Duckering. All rights reserved.
//

import Foundation

struct ReadingPlanSection {
    let name: String
    //let readingsPerDayByMonth: [Int]
    let readingReferences: [String]
    let readingDays: ReadingDays
}
