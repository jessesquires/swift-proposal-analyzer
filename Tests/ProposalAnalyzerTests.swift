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

import XCTest
@testable import ProposalAnalyzer


final class ProposalAnalyzerTests: XCTestCase {

    let fm = FileManager.default

    let proposalsDir: URL = {
        // quick and dirty way to grab the proposals directory in the submodule. lol.
        let testFilePath = NSString(utf8String: #file)! // path to this file
        let testDirectory = testFilePath.deletingLastPathComponent as NSString // path to Tests/ directory
        let projectDirectory = testDirectory.deletingLastPathComponent as NSString
        let submoduleDirectory = projectDirectory.appendingPathComponent("swift-evolution") as NSString
        let proposalsDirectory = submoduleDirectory.appendingPathComponent("proposals")
        return URL(fileURLWithPath: proposalsDirectory, isDirectory: true)
    }()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test() {
        let analyzer = Analyzer(directory: proposalsDir)
        let proposals = analyzer.proposals

        let contents = try! fm.contentsOfDirectory(atPath: proposalsDir.path).sorted()
        let fileNames = proposals.map { $0.fileName }.sorted()

        XCTAssertEqual(proposals.count, contents.count)

        for i in 0..<fileNames.count {
            let name1 = fileNames[i]
            let name2 = contents[i]
            XCTAssertEqual(name1, name2)
        }

        print(proposals);
    }
    
}
