//
//  Created by Rodrigo Reis
//  http://github.com/digoreis
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

public struct ReviewManager {
    public let name: String
    public let url: String
    
    public init(name: String, url : String) {
        self.name = name
        self.url = url
    }
}

extension ReviewManager: CustomStringConvertible {
    public var description: String {
        return name
    }
}

extension ReviewManager: Equatable {
    public static func ==(lhs: ReviewManager, rhs: ReviewManager) -> Bool {
        return lhs.name == rhs.name
    }
}

extension ReviewManager: Comparable {
    public static func < (lhs: ReviewManager, rhs: ReviewManager) -> Bool {
        return lhs.name < rhs.name
    }
}

extension ReviewManager: Hashable {
    public var hashValue: Int {
        return name.hashValue
    }
}
