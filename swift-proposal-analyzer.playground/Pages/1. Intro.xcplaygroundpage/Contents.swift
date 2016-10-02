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
 ### Authors per proposal
 */
printTitle("# authors per proposal")

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


/*:
 ### Proposals per author
 */
printTitle("# proposals per author")
var authorsRanked = [(author: Author, numProposals: Int)]()
for a in authors {
    let n = proposals.filter { $0.authors.contains(a) }.count
    authorsRanked.append((a, n))
}

authorsRanked.sort { $0.numProposals >= $1.numProposals }
for x in authorsRanked {
    print(x.numProposals, x.author)
}


/*:
 ### Word counts
 */
printTitle("word counts")

let totalWords = proposals.map { $0.wordCount }.reduce(0, +)
let avgWordCount = Double(totalWords) / Double(totalProposals)
print("Avg word count:", Int(avgWordCount), "\n")

let wordsPerProposal = proposals.sorted { $0.wordCount > $1.wordCount }
print("Max:\n\(wordsPerProposal.first!)")
print("Min:\n\(wordsPerProposal.last!)")
print("Median:\n\(wordsPerProposal[totalProposals / 2])")


/*:
 ### Word frequency
 */

let text = "Objective-C"
var count = analyzer.occurrences(of: text)
count





/*
 # Other Stats?

 - core team vs community proposals
 - types of proposals: bug, syntax refinement, feature refinement, new feature
 */






/*:
 ----------

 **Continue:** [Next](@next)
 */
