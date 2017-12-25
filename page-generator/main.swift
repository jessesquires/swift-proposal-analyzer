#!/usr/bin/swift

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

print("Generating playground pages from proposals...")

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

if #available(OSX 10.11, *) {
    let process = Process()

    let currentDir = URL(fileURLWithPath: process.currentDirectoryPath)

    let proposalDir = currentDir
        .appendingPathComponent("swift-evolution", isDirectory: true)
        .appendingPathComponent("proposals", isDirectory: true)

    let basePlaygroundDir = currentDir
        .appendingPathComponent("swift-proposal-analyzer.playground", isDirectory: true)
        .appendingPathComponent("Pages", isDirectory: true)

    let proposals = proposalFiles(inDirectory: proposalDir)
    let fm = FileManager.default

    for (url, contents) in proposals {
        let path = url.lastPathComponent
        let range = path.index(path.startIndex, offsetBy: 4)
        let seNumber = "SE-" + path[..<range]

        let pageDir = basePlaygroundDir
            .appendingPathComponent(seNumber + ".xcplaygroundpage", isDirectory: true)

        try! fm.createDirectory(at: pageDir, withIntermediateDirectories: true, attributes: nil)

        let pageFile = pageDir
            .appendingPathComponent("Contents", isDirectory: false)
            .appendingPathExtension("swift")

        let pageContents = "/*:\n"
            + contents
            + "\n\n----------\n\n"
            + "[Previous](@previous) | [Next](@next)\n"
            + "*/\n"

        let pageData = pageContents.data(using: .utf8)
        let success = fm.createFile(atPath: pageFile.path, contents: pageData, attributes: nil)
        if !success {
            print("** Error: failed to generate playground page for " + seNumber)
        }
    }
} else {
    print("** Error: Must use OSX 10.11 or higher.")
}

print("Done! 🎉")
