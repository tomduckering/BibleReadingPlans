//
//  BasicReadingPlan.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 21/12/2016.
//  Copyright © 2017 Tom Duckering. All rights reserved.
//

import Foundation

//struct BasicReadingPlan: ReadingPlan {
//    
//    //outer = days, inner = readings
//    let readings: [[PassageReference]]
//    
//    init(withReadings readings: [[PassageReference]]) {
//        self.readings = readings
//    }
//    
//    private func readings(forDayOfYear dayOfYear: Int) -> ReadingSuggestion {
//        if dayOfYear >= readings.count || dayOfYear < 0 {
//            return ReadingSuggestion(passages: [], canTakeDayOff: true)
//        }
//        let passages = readings[dayOfYear]
//        let suggestion = ReadingSuggestion(passages: passages, canTakeDayOff: false)
//        return suggestion
//    }
//    
//    func readings(forDate date: Date, havingStartedOn startDate: Date) -> ReadingSuggestion {
//        let daysSinceStartedReadingThisPlan = date.days(from: startDate)
//        return readings(forDayOfYear: daysSinceStartedReadingThisPlan)
//    }
//    
//}
