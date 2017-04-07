//  http://www.jessesquires.com
//
//
//  GitHub
//  https://github.com/jessesquires/swift-proposal-analyzer
//
//
//  License
//  Copyright © 2016 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import Foundation

/// Represents a Decision Notes for a proposal.
public struct DecisionNotes {
    public let text: String
    public let url: String
    
    public init(text: String, url : String) {
        self.text = text
        self.url = url
    }
}

extension DecisionNotes: CustomStringConvertible {
    public var description: String {
        return text
    }
}

extension DecisionNotes: Equatable {
    public static func ==(lhs: DecisionNotes, rhs: DecisionNotes) -> Bool {
        return lhs.url == rhs.url
    }
}

extension DecisionNotes: Comparable {
    public static func < (lhs: DecisionNotes, rhs: DecisionNotes) -> Bool {
        return lhs.url < rhs.url
    }
}

extension DecisionNotes: Hashable {
    public var hashValue: Int {
        return url.hashValue
    }
}
