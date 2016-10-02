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
 ## Word counts
 */

let analyzer = Analyzer.shared

let proposals = analyzer.proposals
let totalProposals = analyzer.proposals.count


printTitle("word counts")

let totalWords = proposals.map { $0.wordCount }.reduce(0, +)
let avgWordCount = Double(totalWords) / Double(totalProposals)
print("Average word count:", Int(avgWordCount), "\n")

let wordsPerProposal = proposals.sorted { $0.wordCount > $1.wordCount }
print("Maximum:\n\(wordsPerProposal.first!)")
print("Minimum:\n\(wordsPerProposal.last!)")
print("Median:\n\(wordsPerProposal[totalProposals / 2])")


/*:
 ## Word frequency
 */

let text = "Objective-C"
let count = analyzer.occurrences(of: text)
count



/*:
 ----------

 [Previous](@previous) | [Next](@next)
 */
