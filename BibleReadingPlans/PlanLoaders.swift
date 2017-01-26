//
//  BasicPlanLoader.swift
//  Daily Bread
//
//  Created by Tom Duckering on 21/12/2016.
//  Copyright © 2016 Tom Duckering. All rights reserved.
//

import Foundation

//func loadBasicPlan(withName name:String) -> BasicReadingPlan? {
//    do {
//        guard let mcheynePlanJSONFilePath = Bundle.main.path(forResource: name, ofType: "json") else { return nil }
//        let jsonString = try String(contentsOfFile: mcheynePlanJSONFilePath)
//        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
//        let jsonObject = try JSONSerialization.jsonObject(with: jsonData)
//        return BasicReadingPlan(fromJson: jsonObject)
//        
//    } catch {
//        return nil
//    }
//}
//
//func loadLenientPlan(withName name:String) -> LenientReadingPlan? {
//    do {
//        guard let navigatorsPlanJSONFilePath = Bundle.main.path(forResource: name, ofType: "json") else { return nil }
//        
//        let jsonString = try String(contentsOfFile: navigatorsPlanJSONFilePath)
//        
//        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
//        
//        let jsonObject = try JSONSerialization.jsonObject(with: jsonData)
//        return LenientReadingPlan(fromJson: jsonObject)
//        
//    } catch {
//        return nil
//    }
//}
