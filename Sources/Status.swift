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
    public static var allItems: [Status] {
        return [.inReview, .awaitingReview] + Status.allAccepted + [.deferred, .rejected, .withdrawn]
    }

    public static var allAccepted: [Status] {
        return [Status.accepted] + Status.allImplemented
    }

    public static var allImplemented: [Status]  {
        return SwiftVersion.all.map { Status.implemented($0) }
    }
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
