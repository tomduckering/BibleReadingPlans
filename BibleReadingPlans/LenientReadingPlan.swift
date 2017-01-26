//
//  LenientReadingPlan.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 21/12/2016.
//  Copyright © 2016 Tom Duckering. All rights reserved.
//

import Foundation

//struct LenientReadingPlan: ReadingPlan {
//    
//    //outer = months, next = day in month, inner = readings
//    let readings: [[[PassageReference]]]
//    
//    init(withReadings readings: [[[PassageReference]]]) {
//        self.readings = readings
//    }
//    
//    func readings(forDayOfYear dayOfYear: Int) -> ReadingSuggestion {
//        return ReadingSuggestion(passages: [], canTakeDayOff: false)
//    }
//    
//    func readings(forDate date: Date, havingStartedOn startDate: Date) -> ReadingSuggestion {
//        
//        let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
//        guard let monthNumber = dateComponents.month,
//            let dayNumber = dateComponents.day else
//        { return ReadingSuggestion(passages: [], canTakeDayOff: false) }
//        
//        return ReadingSuggestion(passages: readings[monthNumber-1][dayNumber-1],canTakeDayOff: false)
//        
//    }
//    
//    
//}
