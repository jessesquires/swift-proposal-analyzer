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


print("---------------")
print("Proposal Status")
print("---------------\n")
let statuses = analyzer.proposalStatus()
for s in statuses {
    print(s)
    print()
}


print("------")
print("Totals")
print("------\n")
let accepted = analyzer.proposalsWith(status: Status.allAccepted)
let totalAccepted = accepted.count
let acceptRate = Double(totalAccepted) / Double(totalProposals)
print("Accepted:", totalAccepted, ",", String(format: "%.2f%%", acceptRate * 100))

let implemented = analyzer.proposalsWith(status: Status.allImplemented)
let totalImplemented = implemented.count
let implementationRate = Double(totalImplemented) / Double(totalProposals)
print("Implemented:", totalImplemented, ",", String(format: "%.2f%%", implementationRate * 100))

let deferred = analyzer.proposalsWith(status: .deferred)
let totalDeferred = deferred.count
let deferredRate = Double(totalDeferred) / Double(totalProposals)
print("Deferred:", totalDeferred, ",", String(format: "%.2f%%", deferredRate * 100))

let rejected = analyzer.proposalsWith(status: .deferred)
let totalRejected = rejected.count
let rejectedRate = Double(totalRejected) / Double(totalProposals)
print("Rejected:", totalRejected, ",", String(format: "%.2f%%", rejectedRate * 100))

let withdrawn = analyzer.proposalsWith(status: .withdrawn)
let totalWithdrawn = withdrawn.count
let withdrawnRate = Double(totalWithdrawn) / Double(totalProposals)
print("Withdrawn:", totalWithdrawn, ",", String(format: "%.2f%%", withdrawnRate * 100))

let swift2_2 = analyzer.proposalsWith(status: .implemented(.v2_2)).count
let swift3_0 = analyzer.proposalsWith(status: .implemented(.v3_0)).count
let increase = percentIncrease(from: swift2_2, to: swift3_0)
print()


print("----------------------")
print("# authors per proposal")
print("----------------------\n")
print(totalAuthors, "total authors")
var authorCountSet = Set<Int>()
for p in proposals {
    authorCountSet.insert(p.authors.count)
}

let sortedAuthorCounts = authorCountSet.sorted()
for count in sortedAuthorCounts {
    let numProposals = proposals.filter { $0.authors.count == count }.count
    print(numProposals, "proposals with", count, "authors")
}
let avgAuthorsPerProposal = Double(totalProposals) / Double(totalAuthors)
print("Avg:", String(format: "%.2f", avgAuthorsPerProposal))
print()

print("----------------------")
print("# proposals per author")
print("----------------------\n")
var authorsRanked = [(author: String, numProposals: Int)]()
for a in authors {
    let n = proposals.filter { $0.authors.contains(a) }.count
    authorsRanked.append((a, n))
}

authorsRanked.sort { $0.numProposals >= $1.numProposals }
for x in authorsRanked {
    print(x.numProposals, x.author)
}
print()


print("-----------")
print("word counts")
print("-----------\n")
let totalWords = proposals.map { $0.wordCount }.reduce(0, +)
let avgWordCount = Double(totalWords) / Double(totalProposals)
print("Avg word count:", Int(avgWordCount), "\n")

let wordsPerProposal = proposals.sorted { $0.wordCount > $1.wordCount }
print("Max:\n\(wordsPerProposal.first!)")
print("Min:\n\(wordsPerProposal.last!)")
print("Median\n:\(wordsPerProposal[totalProposals / 2]))")
print()




/*
 # Other Stats?

 - core team vs community proposals
 - types of proposals: bug, syntax refinement, feature refinement, new feature
 */








/*:
 ----------
 
 **Continue:** [Next](@next)
 */
