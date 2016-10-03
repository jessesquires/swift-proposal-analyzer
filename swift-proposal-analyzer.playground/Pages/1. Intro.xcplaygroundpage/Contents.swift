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

/*:
 # Understanding Swift Evolution
 ### What can we learn by analyzing [swift-evolution](https://github.com/apple/swift-evolution) proposals?

 This playground allows you to interact with Swift Evolution Proposals. 
 You can query and filter the proposals based on anything you want.

 **The playground includes:**

 - All of the Swift Evolution proposals
    - As markdown files in `/Resources/`
    - As playground pages in `/Pages/`
 - Code to parse and analyze the proposals

 **Links:**
 - [My talk](https://speakerdeck.com/jessesquires/140-proposals-in-30-minutes)
 - [swift-evolution repo](https://github.com/apple/swift-evolution)
 - [Proposal Status](http://apple.github.io/swift-evolution/)
 - [Swift Evolution Process](https://github.com/apple/swift-evolution/blob/master/process.md)

 --------------
 */

/*:
 ## Proposal data
 
 Let's begin with some basics. First, we parse the proposals into `Proposal` objects. Then we can check the current statuses.
 */

let analyzer = Analyzer(directory: #fileLiteral(resourceName: "proposals"))
let proposals = analyzer.proposals
let authors = analyzer.authors

let totalProposals = proposals.count
let totalAuthors = authors.count

printTitle("Proposal Status")

let statuses = analyzer.proposalStatus()
for s in statuses {
    print(s)
    print()
}


/*:
 ## Examples

 ```
 // Find proposals implemented in Swift 3.0
 let implementedInSwift3 = analyzer.proposalsWith(status: .implemented(.v3_0))
 ```

 ```
 // Find proposals authored or co-authored by Chris Lattner
 let proposalsByLattner = analyzer.proposals.filter { p -> Bool in
    p.writtenBy("Chris Lattner")
 }
 ```

 ```
 // Find total mentions of "Objective-C" across all proposals
 let count = analyzer.occurrences(of: "Objective-C")
 ```

 ----------

 **Continue:** [Next](@next)
 */
