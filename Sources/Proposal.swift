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

public final class Proposal {
    public let title: String
    public let seNumber: String

    public let authors: [Author]
    public let status: Status
    public let reviewManagers: [ReviewManager]

    public let fileName: String
    public let fileContents: String
    public let wordCount: Int

    public init(title: String,
                seNumber: String,
                authors: [Author],
                reviewManagers: [ReviewManager],
                status: Status,
                fileName: String,
                fileContents: String,
                wordCount: Int) {
        self.title = title
        self.seNumber = seNumber

        self.authors = authors
        self.status = status

        self.fileName = fileName
        self.fileContents = fileContents
        self.wordCount = wordCount
        self.reviewManagers = reviewManagers
    }
}

extension Proposal: CustomStringConvertible {
    public var description: String {
        return seNumber + ": " + title
            + "\nAuthor(s): " + authorNames.joined(separator: ", ")
            + "\nStatus: " + "\(status)"
            + "\nFilename: " + fileName
            + "\nWord count: " + "\(wordCount)"
            + "\n"
    }
}

extension Proposal {
    public var number: Int {
        let start = seNumber.index(seNumber.startIndex, offsetBy: 3)
        let str = seNumber.substring(from: start)
        return Int(str)!
    }
}

extension Proposal {
    public var authorNames: [String] {
        return authors.map { $0.name }
    }
    
    public var reviewerNames: [String] {
        return reviewManagers.map { $0.name }
    }
}

extension Proposal {
    private static let baseURL: URL = URL(string: "https://github.com/apple/swift-evolution/blob/master/proposals")!

    public var githubURL: URL {
        return Proposal.baseURL.appendingPathComponent(fileName)
    }
}

extension Proposal {
    public func writtenBy(_ author: Author) -> Bool {
        return authors.contains(author)
    }

    public func writtenBy(_ authorName: String) -> Bool {
        return authorNames.contains(authorName)
    }
}

extension Proposal {
    public func reviewBy(_ reviewer: ReviewManager) -> Bool {
        return reviewManagers.contains(reviewer)
    }
    
    public func reviewBy(_ reviewerName: String) -> Bool {
        return reviewerNames.contains(reviewerName)
    }
}


extension Proposal {
    public func occurrences(of text: String) -> Int {
        let textToFind = text.lowercased()
        var count = 0
        let range = Range(uncheckedBounds: (fileContents.startIndex, fileContents.endIndex))

        fileContents.enumerateSubstrings(in: range, { (substring, substringRange, enclosingRange, stop) in

            if let str = substring?.lowercased(), str.contains(textToFind) {
                count += 1

                let words = str.components(separatedBy: .whitespaces)
                let numOccurrences = words.filter { $0.contains(textToFind) }.count
                if numOccurrences > 1 {
                    count += (numOccurrences - 1) // - 1 because otherwise we would count this twice
                }
            }
        })
        
        return count
    }
}
