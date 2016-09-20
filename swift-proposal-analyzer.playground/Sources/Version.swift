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

public enum SwiftVersion: Double {
    case v2_2 = 2.2
    case v2_3 = 2.3
    case v3_0 = 3.0
    case v3_1 = 3.1
}

extension SwiftVersion: CustomStringConvertible {
    public var description: String {
        return "\(self.rawValue)"
    }
}
