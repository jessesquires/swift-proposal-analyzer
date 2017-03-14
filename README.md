# swift-proposal-analyzer [![Build Status](https://travis-ci.org/jessesquires/swift-proposal-analyzer.svg?branch=master)](https://travis-ci.org/jessesquires/swift-proposal-analyzer)

*An analysis of Swift Evolution proposals*

## About

All of the swift-evolution proposals are publicly available [on GitHub](https://github.com/apple/swift-evolution), however they are just markdown files — plain text. There's no way to query or filter the proposals. For example, you can't search for *"all proposals written by Chris Lattner"* or *"all rejected proposals"* or *"all proposals that mention Objective-C"*.

This project contains tools to analyze, query, and filter the Swift Evolution proposals based on any criteria you like.

This project accompanies [my talk](https://speakerdeck.com/jessesquires/140-proposals-in-30-minutes) from [FrenchKit](http://frenchkit.fr).

## Requirements

- macOS 10.11+
- Xcode 8+
- Swift 3.0+

## Setup

This repo contains a number of different components:

- The [`swift-evolution`](https://github.com/apple/swift-evolution) repo is a [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules). This is how proposals are synced to stay updated.
- `main.swift` is a swift script that generates playground pages for all of the proposals. You can open `proposal-page-generator.xcodeproj` to modify the script.
- `ProposalAnalyzer.xcodeproj` is a CocoaTouch framework that includes all the source code and the playground. This framework is imported in the playground.
- `swift-proposal-analyzer.playground` is the playground (part of the `.xcodeproj`) that contains:
    - All of the proposals as playground pages
    - All of the proposals as raw `Resources/`
    - Examples
- `update_proposals.sh` is a bash script that does the following:
    1.  Updates the `swift-evolution` submodule
    2.  Copies the proposals from the submodule directory, into the playground `Resources/` directory
    2.  Runs `main.swift` to generate the playground pages

#### Cloning this repo

```bash
$ git clone https://github.com/jessesquires/swift-proposal-analyzer.git
$ cd swift-proposal-analyzer/
$ git submodule init
$ git submodule update --remote
$ ./update_proposals.sh
```

## Usage

Open and build `ProposalAnalyzer.xcodeproj`, then select the `swift-proposal-analyzer.playground` and run it like a normal playground.

After parsing completes, you'll have an array of `Proposal` types:

```swift
public final class Proposal {
    public let title: String
    public let seNumber: String

    public let authors: [Author]
    public let status: Status

    public let fileName: String
    public let fileContents: String
    public let wordCount: Int
}
```

Most proposal metadata is available, as well as the raw file contents. You can now perform different queries or apply filters to the proposal data.

## Examples

```swift
// Find proposals implemented in Swift 3.0
let implementedInSwift3 = analyzer.proposalsWith(status: .implemented(.v3_0))
```

```swift
// Find proposals authored or co-authored by Chris Lattner
let proposalsByLattner = analyzer.proposals.filter { p -> Bool in
    p.writtenBy("Chris Lattner")
}
```

```swift
// Find total mentions of "Objective-C" across all proposals
let count = analyzer.occurrences(of: "Objective-C")
```

## Documentation

You can find the (unfinished) [docs here](http://www.jessesquires.com/swift-proposal-analyzer/).

## Caveats

Some of the code here is pretty "quicky and dirty", but it works! So `¯\_(ツ)_/¯ ` :laughing: If there's a better way to do something, please [submit a pull request](https://github.com/jessesquires/swift-proposal-analyzer/pulls)!

This is a small dataset, so any conclusions should be taken with a grain of salt. :smile:

## Credits

Created and maintained by [**@jesse_squires**](https://twitter.com/jesse_squires).

## License

Released under an [MIT License](http://opensource.org/licenses/MIT). See `LICENSE` for details.

>**Copyright &copy; 2016-present Jesse Squires.**
