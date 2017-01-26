//
//  ReadingRecordProtocol.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 26/01/2017.
//  Copyright © 2017 Tom Duckering. All rights reserved.
//

import Foundation
public enum ReadingRecordType: String {
    case Genuine = "Genuine"
    case ManuallyAdded = "ManuallyAdded"
}

public protocol ReadingRecordProtocol {
    var passageReference: String { get set }
    var dateTimeRead: Date { get set }
    var type: ReadingRecordType {get set}
}
