
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


public func parseProposals(inDirectory directory: URL) -> [Proposal] {
    let fm = FileManager.default
    let proposalNames = try! fm.contentsOfDirectory(atPath: directory.path)
    let fileURLs = proposalFileURLs(fromNames: proposalNames, inDirectory: directory)
    let files = proposalFiles(fromURLs: fileURLs)

    var allProposals = [Proposal]()
    for i in 0..<files.count {
        let fileName = proposalNames[i]
        let fileContents = files[i]
        let proposal = proposalFromFile(contents: fileContents, fileName: fileName)
        allProposals.append(proposal)
    }

    return allProposals
}


func proposalFileURLs(fromNames allProposalNames: [String], inDirectory directory: URL) -> [URL] {
    var proposalPaths = [URL]()
    for eachName in allProposalNames {
        let url = directory.appendingPathComponent(eachName)
        proposalPaths.append(url)
    }
    return proposalPaths
}


func proposalFiles(fromURLs proposalURLs: [URL]) -> [String] {
    var proposalFiles = [String]()
    for eachFile in proposalURLs {
        let fileContents = try! String(contentsOf: eachFile, encoding: String.Encoding.utf8)
        proposalFiles.append(fileContents)
    }
    return proposalFiles
}


func proposalFromFile(contents: String, fileName: String) -> Proposal {
    let lines = proposalLines(10, fromFile: contents)

    let titleLine = lines[0]
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

    return Proposal(title: title, number: seNumber, fileName: fileName, authors: authors, status: status)
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
    return line.trimmingCharacters(in: CharacterSet(["#", " "]))
}


func seNumberFromLine(_ line: String) -> String {
    let range = line.index(line.startIndex, offsetBy: 13)..<line.index(line.startIndex, offsetBy: 20)
    return line.substring(with: range)
}


func authorsFromLine(_ line: String, multiple: Bool) -> [String] {
    let range = line.index(line.startIndex, offsetBy: multiple ? 11 : 10)
    let authorString = line.substring(from: range)
    let authorComponents = authorString.components(separatedBy: ",")

    var authorNames = [String]()
    for eachAuthor in authorComponents {
        let components = eachAuthor.components(separatedBy: CharacterSet(["[", "]"]))
        if components.count > 1 {
            authorNames.append(components[1].trimmingCharacters(in: .whitespacesAndNewlines))
        } else {
            authorNames.append(components[0].trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }

    return authorNames
}


func statusStringFromLine(_ line: String) -> String {
    let range = line.index(line.startIndex, offsetBy: 10)
    let statusString = line.substring(from: range)
    return statusString.trimmingCharacters(in: CharacterSet(["*"]))
}
