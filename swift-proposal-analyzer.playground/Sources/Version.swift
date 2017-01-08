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

public struct SwiftVersion {
    public let major: Int
    public let minor: Int
    public let patch: Int

    public static let v2_2 = SwiftVersion(major: 2, minor: 2, patch: 0)
    public static let v2_3 = SwiftVersion(major: 2, minor: 3, patch: 0)

    public static let v3_0 = SwiftVersion(major: 3, minor: 0, patch: 0)
    public static let v3_0_1 = SwiftVersion(major: 3, minor: 0, patch: 1)
    public static let v3_1 = SwiftVersion(major: 3, minor: 1, patch: 0)

    public static let v4_0 = SwiftVersion(major: 4, minor: 0, patch: 0)
}

extension SwiftVersion {
    public static let all: [SwiftVersion] = [.v2_2, .v2_3,
                                             .v3_0, .v3_0_1, .v3_1,
                                             .v4_0]
}

extension SwiftVersion: CustomStringConvertible {
    public var description: String {
        return  "\(major).\(minor)" + ((patch != 0) ? ".\(patch)" : "")
    }
}

extension SwiftVersion: Equatable {
    public static func ==(lhs: SwiftVersion, rhs: SwiftVersion) -> Bool {
        return lhs.major == rhs.major
            && lhs.minor == rhs.minor
            && lhs.patch == rhs.patch
    }
}

extension SwiftVersion: Comparable {
    public static func < (lhs: SwiftVersion, rhs: SwiftVersion) -> Bool {
        if lhs.major == rhs.major {
            if lhs.minor == rhs.minor {
                return lhs.patch < rhs.patch
            }
            return lhs.minor < rhs.minor
        }
        return lhs.major < rhs.major
    }
}

extension SwiftVersion: Hashable {
    public var hashValue: Int {
        return major.hashValue ^ minor.hashValue ^ patch.hashValue
    }
}
