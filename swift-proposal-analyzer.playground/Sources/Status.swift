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

public enum Status {
    case inReview
    case awaitingReview
    case accepted
    case implemented(SwiftVersion)
    case deferred
    case rejected
    case withdrawn
}

extension Status {
    public static let allItems = [
        Status.inReview,
        Status.awaitingReview,
        Status.accepted,
        Status.implemented(.v2_2),
        Status.implemented(.v2_3),
        Status.implemented(.v3_0),
        Status.implemented(.v3_1),
        Status.deferred,
        Status.rejected,
        Status.withdrawn
    ]

    public static let allImplemented = [
        Status.implemented(.v2_2),
        Status.implemented(.v2_3),
        Status.implemented(.v3_0),
        Status.implemented(.v3_1)
    ]

    public static let allAccepted = [
        Status.accepted,
        Status.implemented(.v2_2),
        Status.implemented(.v2_3),
        Status.implemented(.v3_0),
        Status.implemented(.v3_1)
    ]
}

extension Status: Hashable {
    public var hashValue: Int {
        return description.hashValue
    }
}

extension Status: Equatable {
    public static func ==(lhs: Status, rhs: Status) -> Bool {
        switch (lhs, rhs) {
        case (.inReview, .inReview):
            return true
        case (.awaitingReview, .awaitingReview):
            return true
        case (.accepted, .accepted):
            return true
        case (let .implemented(v1), let .implemented(v2)):
            return v1 == v2
        case (.deferred, .deferred):
            return true
        case (.rejected, .rejected):
            return true
        case (.withdrawn, .withdrawn):
            return true
        default:
            return false
        }
    }
}

extension Status: CustomStringConvertible {
    public var description: String {
        switch self {
        case .inReview: return "In review"
        case .awaitingReview: return "Awaiting review"
        case .accepted: return "Accepted (awaiting implementation)"
        case .implemented(let v): return "Implemented (\(v))"
        case .deferred: return "Deferred"
        case .rejected: return "Rejected"
        case .withdrawn: return "Withdrawn"
        }
    }
}
