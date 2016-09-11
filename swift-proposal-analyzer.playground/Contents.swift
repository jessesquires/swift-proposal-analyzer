//: Playground - noun: a place where people can play

import Foundation
import UIKit

let directory = #fileLiteral(resourceName: "proposals")
let proposals = parseProposals(inDirectory: directory)

var allAuthors = NSCountedSet()
for p in proposals {
    allAuthors.addObjects(from: p.authors)
}

for a in allAuthors {
    print(a, ": ", allAuthors.count(for: a))
}

