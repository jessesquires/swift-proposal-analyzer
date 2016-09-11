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
    public let number: String
    public let fileName: String
    public let authors: [String]
    public let status: String

    public init(title: String, number: String, fileName: String, authors: [String], status: String) {
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.number = number.trimmingCharacters(in: .whitespacesAndNewlines)
        self.fileName = fileName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.authors = authors
        self.status = status.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}


extension Proposal: CustomStringConvertible {
    public var description: String {
        return number + ": " + title
            + "\nBy: " + "\(authors)"
            + "\nStatus: " + status
            + "\n"
    }
}
