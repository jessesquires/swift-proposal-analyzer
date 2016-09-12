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
 ### What can we learn by analyzing [swift-evolution](https://github.com/apple/swift-evolution) proposals?

 **Links:**
 - [swift-evolution repo](https://github.com/apple/swift-evolution)
 - [Proposal Status](http://apple.github.io/swift-evolution/)
 - [Swift Evolution Process](https://github.com/apple/swift-evolution/blob/master/process.md)

 **This playground includes:**
 
 - All of the Swift Evolution proposals
    - As markdown files in `/Resources/`
    - As playground pages in `/Pages/`
 - Code to parse and analyze the proposals
 
 --------------
 */

let analyzer = Analyzer(directory: #fileLiteral(resourceName: "proposals"))
let proposals = analyzer.proposals
let authors = analyzer.authors

let totalProposals = proposals.count
let totalAuthors = authors.count

let statuses = analyzer.proposalStatus()
for s in statuses {
    print(s)
    print()
}

let accepted = analyzer.proposalsWith(status: Status.allAccepted)
let totalAccepted = accepted.count
let acceptRate = Double(totalAccepted) / Double(totalProposals)

let implemented = analyzer.proposalsWith(status: Status.allImplemented)
let totalImplemented = implemented.count
let implementationRate = Double(totalImplemented) / Double(totalProposals)

let deferred = analyzer.proposalsWith(status: .deferred)
let totalDeferred = deferred.count

//let proposalsPerAuthor = analyzer.proposalsPerAuthor
//for a in authors {
//    print(a, proposalsPerAuthor.count(for: a), separator: " : ", terminator: "\n")
//}




/*:
 ----------
 
 **Continue:** [Next](@next)
 */
