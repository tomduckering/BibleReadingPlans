//
//  ReadingPlanJSONInitialisers.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 23/01/2017.
//  Copyright © 2017 Tom Duckering. All rights reserved.
//

import Foundation

extension BibleEaterPlan {
    public init?(fromJSON json: [String:Any]) {
        guard let name = json["name"] as? String,
            let periodsJSON = json["periods"] as? [[String:Any]]
            else {
                //Unable to construct a plan without string...
                return nil
        }
        self.name = name
        self.periods = periodsJSON.map { json in ReadingPlanPeriod(fromJSON: json)! }
    }

    enum BibleEaterPlanLoadError: Error {
        case couldntFindFileInBundle(name: String)
        case couldntDeserializeJSON
        case couldntInitialisePlanFromJSON
    }

    public init?(fromBundle bundle: Bundle = Bundle.main, withName name: String) {
        do {
            guard let navigatorsPlanJSONFilePath = bundle.path(forResource: name, ofType: "json")
                else {
                    throw BibleEaterPlanLoadError.couldntFindFileInBundle(name: name)
            }

            let jsonString = try String(contentsOfFile: navigatorsPlanJSONFilePath)

            guard let jsonData = jsonString.data(using: .utf8),
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData) as? [String:Any]
                else {
                    throw BibleEaterPlanLoadError.couldntDeserializeJSON
            }

            self.init(fromJSON: jsonObject)

        } catch {
            return nil
        }
    }
}

extension ReadingPlanSection {
    init?(fromJSON json: [String:Any], withName name: String) {
        guard
            let readingReferences = json["readings"] as? [String]
            else {
                return nil
        }
        //self.readingsPerDayByMonth = readinsPerDayByMonth
        self.readingReferences = readingReferences
        self.name = name
        if let numberOfDaysOff = json["days_off_per_month"] as? Int {
            self.readingDays = ReadingDays.off(days: numberOfDaysOff)
        } else if let numberOfDaysOn = json["days_on_per_month"] as? Int {
            self.readingDays = ReadingDays.on(days: numberOfDaysOn)
        } else {
            self.readingDays = ReadingDays.all
        }

    }
}

extension ReadingPlanPeriod {
    init?(fromJSON json: [String:Any]) {
        guard let name = json["name"] as? String,
            let startDate = json["month_start"] as? Int,
            let endDate = json["month_end"] as? Int,
            let sectionsJSON = json["sections"] as? [String:[String:Any]]
            else {
                return nil
        }
        self.name = name
        self.startMonth = startDate
        self.endMonth = endDate
        self.sections = sectionsJSON.map { name, json in ReadingPlanSection(fromJSON: json, withName: name)! }
    }
}
