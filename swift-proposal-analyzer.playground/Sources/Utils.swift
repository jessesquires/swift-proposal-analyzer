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

public func printTitle(_ title: String) {
    let line = String(repeating: "-", count: title.characters.count)
    print()
    print(line)
    print(title)
    print(line)
    print()
}

public func percentIncrease(from: Int, to: Int) -> Double {
    let increase = Double(to) - Double(from)
    if (from == 0) {
        return increase * 100.0
    }
    return (increase / Double(from)) * 100.0
}

