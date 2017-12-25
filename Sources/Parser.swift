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
        let proposal = proposalFrom(fileContents: fileContents, fileName: url.lastPathComponent)
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


func proposalFrom(fileContents: String, fileName: String) -> Proposal {
    let lines = proposalLines(10, fromFile: fileContents)

    let titleLine = lines[0].trimmingWhitespace()
    var seNumberLine: String!
    var singleAuthorLine: String?
    var multipleAuthorLine: String?
    var statusLine: String!
    var reviewManagerLine: String?
    var decisionNotesLine: String?
    var bugLine: String?

    for eachLine in lines {
        if eachLine.hasPrefix("* Proposal:") || eachLine.hasPrefix("- Proposal:") {
            seNumberLine = eachLine
        }

        if eachLine.hasPrefix("* Author:") || eachLine.hasPrefix("- Author:") {
            singleAuthorLine = eachLine
        }

        if eachLine.hasPrefix("* Authors:") || eachLine.hasPrefix("- Authors:") {
            multipleAuthorLine = eachLine
        }

        if eachLine.hasPrefix("* Status: ") || eachLine.hasPrefix("- Status: ") {
            statusLine = eachLine
        }
        
        if eachLine.hasPrefix("* Review Manager:") || eachLine.hasPrefix("- Review Manager:") {
            reviewManagerLine = eachLine
        }
        
        if eachLine.hasPrefix("* Decision Notes:") || eachLine.hasPrefix("- Decision Notes:") {
            decisionNotesLine = eachLine
        }

        if eachLine.hasPrefix("* Bug:") || eachLine.hasPrefix("- Bug:") {
            bugLine = eachLine
        }
    }

    if seNumberLine == nil || statusLine == nil {
        assertionFailure("*** Error processing file: " + fileName)
    }

    let title = nameFromLine(titleLine)
    let seNumber = seNumberFromLine(seNumberLine)

    let authorLine: String! = singleAuthorLine ?? multipleAuthorLine
    let authors = authorsFromLine(authorLine, multiple: (singleAuthorLine == nil))

    let status = statusFromLine(statusLine)
    let words = wordCount(fromFile: fileContents)
    
    let reviewManagers = reviewManagerFromString(reviewManagerLine)
    let decisionNotes = decisionNoteFromLine(decisionNotesLine)
    let bugs = bugsFromString(bugLine)
    
    return Proposal(title: title,
                    seNumber: seNumber,
                    authors: authors,
                    reviewManagers: reviewManagers,
                    decisionNotes: decisionNotes,
                    bugs: bugs,
                    status: status,
                    fileName: fileName,
                    fileContents: fileContents,
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
    let trimmedChars = CharacterSet.punctuationCharacters.union(.symbols)

    return file.components(separatedBy: .whitespacesAndNewlines)
        .map { $0.trimmingCharacters(in: trimmedChars) }
        .filter { $0 != "" }.count
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
    return String(line[range]).trimmingWhitespace()
}


func authorsFromLine(_ line: String, multiple: Bool) -> [Author] {
    let range = line.index(line.startIndex, offsetBy: multiple ? 11 : 10)
    let authorString = String(line[range])
    let authorComponents = authorString.components(separatedBy: ",")

    var authors = [Author]()
    for eachAuthor in authorComponents {
        let components = eachAuthor.components(separatedBy: CharacterSet(["[", "]"]))
        if components.count > 1 {
            let name = components[1].trimmingWhitespace()
            authors.append(Author(name: name))
        } else {
            let name = components[0].trimmingWhitespace()
            authors.append(Author(name: name))
        }
    }

    return authors
}


func statusFromLine(_ line: String) -> Status {
//    let range = line.index(line.startIndex, offsetBy: 10)
//    let string = String(line[range])
//    let characters = CharacterSet.whitespacesAndNewlines.union(CharacterSet(["*"]))
    let statusString = line //string.trimmingCharacters(in: characters)

    switch statusString {
    case _ where statusString.localizedCaseInsensitiveContains("Active Review"):
        return .inReview
    case _ where statusString.localizedCaseInsensitiveContains("Awaiting Review"): fallthrough
    case _ where statusString.localizedCaseInsensitiveContains("Returned for revision"):
        return .awaitingReview
    case _ where statusString.localizedCaseInsensitiveContains("Accepted"):
        return .accepted
    case _ where statusString.localizedCaseInsensitiveContains("Implemented"):
        let version = versionFromString(statusString)
        return .implemented(version)
    case _ where statusString.localizedCaseInsensitiveContains("Deferred"):
        return .deferred
    case _ where statusString.localizedCaseInsensitiveContains("Rejected"):
        return .rejected
    case _ where statusString.localizedCaseInsensitiveContains("Withdrawn"):
        return .withdrawn
    default:
        fatalError("** Error: unknown status found in line: " + line)
    }
}


func versionFromString(_ versionString: String) -> SwiftVersion {
    switch versionString {
    case _ where versionString.localizedCaseInsensitiveContains("Swift 2.2"):
        return .v2_2
    case _ where versionString.localizedCaseInsensitiveContains("Swift 2.3"):
        return .v2_3
    case _ where versionString.localizedCaseInsensitiveContains("Swift 3.1"):
        return .v3_1
    case _ where versionString.localizedCaseInsensitiveContains("Swift 3.0.1"):
        return .v3_0_1
    case _ where versionString.localizedCaseInsensitiveContains("Swift 3.0"): fallthrough
    case _ where versionString.localizedCaseInsensitiveContains("Swift 3"):
        return .v3_0
    case _ where versionString.localizedCaseInsensitiveContains("Swift 4.1"):
        return .v4_1
    case _ where versionString.localizedCaseInsensitiveContains("Swift 4"):
        return .v4_0
    default:
        fatalError("** Error: unknown version number found: " + versionString)
    }
}

func reviewManagerFromString(_ line: String?) -> [ReviewManager] {
    var reviewers = [ReviewManager]()
    
    guard let line = line else { return reviewers }
    
    let range = line.index(line.startIndex, offsetBy: 18)
    let reviewManagerString = String(line[range])
    let reviewManagerStringComponents = reviewManagerString.components(separatedBy: ",")
    
    for eachReviewer in reviewManagerStringComponents {
        let componentsName = eachReviewer.components(separatedBy: CharacterSet(["[", "]"]))
        let componentsUrl = eachReviewer.components(separatedBy: CharacterSet(["(", ")"]))
        if componentsName.count > 1 {
            let name = componentsName[1].trimmingWhitespace()
            let url = (componentsUrl.count > 1) ? componentsUrl[1].trimmingWhitespace() : ""
            reviewers.append(ReviewManager(name: name, url: url))
        } else {
            let name = componentsName[0].trimmingWhitespace()
            let url = (componentsUrl.count > 0) ? componentsUrl[0].trimmingWhitespace() : ""
            reviewers.append(ReviewManager(name: name, url: url))
        }
    }
    return reviewers
}

func decisionNoteFromLine(_ line: String?) -> DecisionNotes? {
    var decisionNotes : DecisionNotes?
    guard let line = line else { return nil }
    let componentsTitle = line.components(separatedBy: CharacterSet(["[", "]"]))
    let componentsUrl = line.components(separatedBy: CharacterSet(["(", ")"]))
    let text = componentsTitle[1].trimmingWhitespace()
    let url = (componentsUrl.count > 1) ? componentsUrl[1].trimmingWhitespace() : ""
    if text != "" && url != "" {
        decisionNotes = DecisionNotes(text: text, url: url)
    }
    return decisionNotes
}

func bugsFromString(_ line: String?) -> [Bug] {
    var bugs = [Bug]()
    
    guard let line = line else { return bugs }
    
    let range = line.index(line.startIndex, offsetBy: 7)
    let bugString = String(line[range])
    let bugStringComponents = bugString.components(separatedBy: ",")
    
    for eachBug in bugStringComponents {
        let componentsName = eachBug.components(separatedBy: CharacterSet(["[", "]"]))
        let componentsUrl = eachBug.components(separatedBy: CharacterSet(["(", ")"]))
        if componentsName.count > 1 {
            let srNumber = componentsName[1].trimmingWhitespace()
            let url = (componentsUrl.count > 1) ? componentsUrl[1].trimmingWhitespace() : ""
            bugs.append(Bug(srNumber: srNumber, url: url))
        } else {
            let srNumber = componentsName[0].trimmingWhitespace()
            let url = (componentsUrl.count > 0) ? componentsUrl[0].trimmingWhitespace() : ""
            bugs.append(Bug(srNumber: srNumber, url: url))
        }
    }
    return bugs
}
