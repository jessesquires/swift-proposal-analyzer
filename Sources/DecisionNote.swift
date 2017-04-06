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

/// Represents a review manager for a proposal.
public struct DecisionNote {
    public let title: String
    public let url: String
    
    public init(title: String, url : String) {
        self.title = title
        self.url = url
    }
}

extension DecisionNote: CustomStringConvertible {
    public var description: String {
        return title
    }
}

extension DecisionNote: Equatable {
    public static func ==(lhs: DecisionNote, rhs: DecisionNote) -> Bool {
        return lhs.title == rhs.title
    }
}

extension DecisionNote: Comparable {
    public static func < (lhs: DecisionNote, rhs: DecisionNote) -> Bool {
        return lhs.title < rhs.title
    }
}

extension DecisionNote: Hashable {
    public var hashValue: Int {
        return title.hashValue
    }
}
