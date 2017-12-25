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
import ProposalAnalyzer

/*:
 ## Proposal status
 
 Here, we look at proposals per status as a percentage of total proposals.
 */

let analyzer = Analyzer.shared

let totalProposals = analyzer.proposals.count
let totalAuthors = analyzer.authors.count


printTitle("Totals")

let accepted = analyzer.proposalsWith(status: Status.allAccepted)
let acceptedNotImplemented = analyzer.proposalsWith(status: .accepted)
let totalAccepted = accepted.count
let acceptRate = Double(totalAccepted) / Double(totalProposals)
print("Accepted: \(totalAccepted), " + String(format: "%.2f%%", acceptRate * 100) + ", (not implemented: \(acceptedNotImplemented.count))")

let implemented = analyzer.proposalsWith(status: Status.allImplemented)
let totalImplemented = implemented.count
let implementationRate = Double(totalImplemented) / Double(totalProposals)
print("Implemented: \(totalImplemented),", String(format: "%.2f%%", implementationRate * 100))

let deferred = analyzer.proposalsWith(status: .deferred)
let totalDeferred = deferred.count
let deferredRate = Double(totalDeferred) / Double(totalProposals)
print("Deferred: \(totalDeferred),", String(format: "%.2f%%", deferredRate * 100))

let rejected = analyzer.proposalsWith(status: .rejected)
let totalRejected = rejected.count
let rejectedRate = Double(totalRejected) / Double(totalProposals)
print("Rejected: \(totalRejected),", String(format: "%.2f%%", rejectedRate * 100))

let withdrawn = analyzer.proposalsWith(status: .withdrawn)
let totalWithdrawn = withdrawn.count
let withdrawnRate = Double(totalWithdrawn) / Double(totalProposals)
print("Withdrawn: \(totalWithdrawn),", String(format: "%.2f%%", withdrawnRate * 100))


/*:
 ## Other queries
 */

let swift2_2 = analyzer.proposalsWith(status: .implemented(.v2_2)).count
let swift3_0 = analyzer.proposalsWith(status: .implemented(.v3_0)).count
let increase = percentIncrease(from: swift2_2, to: swift3_0)

let implementedInSwift3 = analyzer.proposalsWith(status: .implemented(.v3_0))

let implementedInSwift4_1 = analyzer.proposalsWith(status: .implemented(.v4_1))

/*:
 ----------

 [Previous](@previous) | [Next](@next)
 */
