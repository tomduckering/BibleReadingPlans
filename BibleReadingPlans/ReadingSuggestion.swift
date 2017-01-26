//
//  ReadingSuggestion.swift
//  BibleReadingPlans
//
//  Created by Tom Duckering on 23/01/2017.
//  Copyright © 2017 Tom Duckering. All rights reserved.
//

import Foundation

public struct ReadingSuggestion: Equatable {
    public let readingReference: String
    public let hasBeenRead: Bool

    public static func == (lhs: ReadingSuggestion, rhs: ReadingSuggestion) -> Bool {
        return lhs.readingReference == rhs.readingReference && lhs.hasBeenRead == rhs.hasBeenRead
    }
}
