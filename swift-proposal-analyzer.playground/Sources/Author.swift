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

public struct Author {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}

extension Author: CustomStringConvertible {
    public var description: String {
        return name
    }
}

extension Author: Equatable {
    public static func ==(lhs: Author, rhs: Author) -> Bool {
        return lhs.name == rhs.name
    }
}

extension Author: Comparable {
    public static func < (lhs: Author, rhs: Author) -> Bool {
        return lhs.name < rhs.name
    }
}

extension Author: Hashable {
    public var hashValue: Int {
        return name.hashValue
    }
}
