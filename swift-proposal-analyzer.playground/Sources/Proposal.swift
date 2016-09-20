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

public struct Proposal {
    public let title: String
    public let seNumber: String
    public let authors: [String]
    public let status: Status

    public let fileName: String
    public let wordCount: Int

    public init(title: String,
                seNumber: String,
                authors: [String],
                status: Status,
                fileName: String,
                wordCount: Int) {
        self.title = title
        self.seNumber = seNumber
        self.authors = authors
        self.status = status

        self.fileName = fileName
        self.wordCount = wordCount
    }
}

extension Proposal: CustomStringConvertible {
    public var description: String {
        return seNumber + ": " + title
            + "\nAuthor(s): " + authors.joined(separator: ", ")
            + "\nStatus: " + "\(status)"
            + "\nFilename: " + fileName
            + "\nWord count: " + "\(wordCount)"
            + "\n"
    }
}

extension Proposal {
    private static let baseURL: URL = URL(string: "https://github.com/apple/swift-evolution/blob/master/proposals")!

    public var githubURL: URL {
        return Proposal.baseURL.appendingPathComponent(fileName)
    }
}

extension Proposal {
    public var number: Int {
        let start = seNumber.index(seNumber.startIndex, offsetBy: 3)
        let str = seNumber.substring(from: start)
        return Int(str)!
    }
}
