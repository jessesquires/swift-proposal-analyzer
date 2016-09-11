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


public func parseProposals(inDirectory directory: URL) -> [Proposal] {
    let files = proposalFiles(inDirectory: directory)

    var allProposals = [Proposal]()
    for (url, fileContents) in files {
        let proposal = proposalFromFile(contents: fileContents, fileName: url.lastPathComponent)
        allProposals.append(proposal)
    }

    return allProposals.sorted { p1, p2 -> Bool in
        p1.seNumber < p2.seNumber
    }
}


func proposalFiles(inDirectory directory: URL) -> [URL : String] {
    let fm = FileManager.default
    let proposalNames = try! fm.contentsOfDirectory(atPath: directory.path)
    var proposals = [URL : String]()

    for eachName in proposalNames {
        let url = directory.appendingPathComponent(eachName)
        let fileContents = try! String(contentsOf: url, encoding: String.Encoding.utf8)
        proposals[url] = fileContents
    }
    return proposals
}


func proposalFromFile(contents: String, fileName: String) -> Proposal {
    let lines = proposalLines(10, fromFile: contents)

    let titleLine = lines[0].trimmingWhitespace()
    var seNumberLine: String!
    var singleAuthorLine: String?
    var multipleAuthorLine: String?
    var statusLine: String!

    for eachLine in lines {
        if eachLine.hasPrefix("* Proposal:") {
            seNumberLine = eachLine
        }

        if eachLine.hasPrefix("* Author:") {
            singleAuthorLine = eachLine
        }

        if eachLine.hasPrefix("* Authors:") {
            multipleAuthorLine = eachLine
        }

        if eachLine.hasPrefix("* Status: ") {
            statusLine = eachLine
        }
    }

    let title = nameFromLine(titleLine)
    let seNumber = seNumberFromLine(seNumberLine)

    let authorLine: String! = singleAuthorLine ?? multipleAuthorLine
    let authors = authorsFromLine(authorLine, multiple: (singleAuthorLine == nil))

    let status = statusStringFromLine(statusLine)

    let words = wordCount(fromFile: contents)

    return Proposal(title: title,
                    seNumber: seNumber,
                    authors: authors,
                    status: status,
                    fileName: fileName,
                    wordCount: words)
}

extension String {
    func trimmingWhitespace() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}


func wordCount(fromFile file: String) -> Int {
    // yes, this is extremely naive and not very precise
    // but good enough to get a basic idea of word count
    // also, i'm lazy
    return file.components(separatedBy: .whitespaces).count
}


func proposalLines(_ numberOfLines: Int, fromFile file: String) -> [String] {
    var lines = [String]()
    var count = 0
    file.enumerateLines { line, stop in
        lines.append(line)
        count += 1

        if count >= numberOfLines {
            stop = true
        }
    }
    return lines
}


func nameFromLine(_ line: String) -> String {
    return line.trimmingCharacters(in: CharacterSet(["#", " "])).trimmingWhitespace()
}


func seNumberFromLine(_ line: String) -> String {
    let start = line.index(line.startIndex, offsetBy: 13)
    let range = start..<line.index(start, offsetBy: 7)
    return line.substring(with: range).trimmingWhitespace()
}


func authorsFromLine(_ line: String, multiple: Bool) -> [String] {
    let range = line.index(line.startIndex, offsetBy: multiple ? 11 : 10)
    let authorString = line.substring(from: range)
    let authorComponents = authorString.components(separatedBy: ",")

    var authorNames = [String]()
    for eachAuthor in authorComponents {
        let components = eachAuthor.components(separatedBy: CharacterSet(["[", "]"]))
        if components.count > 1 {
            authorNames.append(components[1].trimmingWhitespace())
        } else {
            authorNames.append(components[0].trimmingWhitespace())
        }
    }

    return authorNames
}


func statusStringFromLine(_ line: String) -> String {
    let range = line.index(line.startIndex, offsetBy: 10)
    let statusString = line.substring(from: range)
    return statusString.trimmingCharacters(in: CharacterSet(["*"])).trimmingWhitespace()
}
