//
//  FakeManagedObjects.swift
//  Daily Bread
//
//  Created by Tom Duckering on 22/12/2016.
//  Copyright © 2016 Tom Duckering. All rights reserved.
//

import Foundation



class FakeReadingRecord: ReadingRecordProtocol {


    var passageReference: String
    var dateTimeRead: Date
    private var recordType: String

    var type: ReadingRecordType {
        get {
            return ReadingRecordType(rawValue: self.recordType)!
        }
        set {
            self.recordType = newValue.rawValue
        }
    }

    init(passageReference reference: String, dateTimeRead date: Date, recordType: String = "Genuine") {
        self.passageReference = reference
        self.dateTimeRead = date
        self.recordType = recordType
    }
}
