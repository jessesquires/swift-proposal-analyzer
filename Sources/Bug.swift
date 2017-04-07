//
//  Created by Jesse Squires
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

/// Represents Bugs for a proposal.
public struct Bug {
    public let srNumber: String
    public let url: String
    
    public init(srNumber: String, url : String) {
        self.srNumber = srNumber
        self.url = url
    }
}

extension Bug: CustomStringConvertible {
    public var description: String {
        return srNumber
    }
}

extension Bug: Equatable {
    public static func ==(lhs: Bug, rhs: Bug) -> Bool {
        return lhs.srNumber == rhs.srNumber
    }
}

extension Bug: Comparable {
    public static func < (lhs: Bug, rhs: Bug) -> Bool {
        return lhs.srNumber < rhs.srNumber
    }
}

extension Bug: Hashable {
    public var hashValue: Int {
        return srNumber.hashValue
    }
}
