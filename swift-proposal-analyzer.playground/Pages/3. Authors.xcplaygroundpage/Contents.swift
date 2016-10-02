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
 ## Authors per proposal
 */

let analyzer = Analyzer.shared

let proposals = analyzer.proposals
let authors = analyzer.authors

let totalProposals = proposals.count
let totalAuthors = authors.count


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
 ## Proposals per author
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
 ----------

 [Previous](@previous) | [Next](@next)
 */
