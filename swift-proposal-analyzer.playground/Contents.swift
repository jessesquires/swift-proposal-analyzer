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
import UIKit

let analyzer = Analyzer(directory: #fileLiteral(resourceName: "proposals"))
let proposals = analyzer.proposals

for p in proposals {
    print(p)
}

let allAuthors = analyzer.allAuthors

for a in allAuthors {
    print(a, allAuthors.count(for: a), separator: " : ", terminator: "\n")
}
