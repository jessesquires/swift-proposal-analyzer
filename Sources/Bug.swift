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

/// Represents a review manager for a proposal.
public struct Bug {
    public let code: String
    public let url: String
    
    public init(code: String, url : String) {
        self.code = code
        self.url = url
    }
}

extension Bug: CustomStringConvertible {
    public var description: String {
        return code
    }
}

extension Bug: Equatable {
    public static func ==(lhs: Bug, rhs: Bug) -> Bool {
        return lhs.code == rhs.code
    }
}

extension Bug: Comparable {
    public static func < (lhs: Bug, rhs: Bug) -> Bool {
        return lhs.code < rhs.code
    }
}

extension Bug: Hashable {
    public var hashValue: Int {
        return code.hashValue
    }
}
