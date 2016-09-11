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

/*:
 # Understanding Swift Evolution
 ### What can we learn by analyzing swift-evolution proposals?

 This playground includes all of the Swift Evolution proposals as resource files in `Resources/` as well playground pages in `Pages/`.
 */

let analyzer = Analyzer(directory: #fileLiteral(resourceName: "proposals"))
let proposals = analyzer.proposals
let authors = analyzer.authors

let totalAuthors = authors.count

for p in proposals {
    print(p)
}

let proposalsPerAuthor = analyzer.proposalsPerAuthor
for a in authors {
    print(a, proposalsPerAuthor.count(for: a), separator: " : ", terminator: "\n")
}


/*
 TODO:
 
 - number of line
 - word count
 */





/*:
 [Previous](@previous) | [Next](@next)
 */
