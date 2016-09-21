# swift-proposal-analyzer

*An analysis of Swift Evolution proposals*

## About

> TODO:

## Requirements

- OSX 10.11
- Xcode 8
- Swift 3.0

## Setup

The [`swift-evolution`](https://github.com/apple/swift-evolution) repo is a [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

#### Cloning

```bash
$ git clone https://github.com/jessesquires/swift-proposal-analyzer.git
$ cd swift-proposal-analyzer/
$ git submodule init
$ git submodule update --remote
```

#### Updating proposals

Pulls the latest from [`swift-evolution`](https://github.com/apple/swift-evolution) and adds them to the playground.

```bash
$ ./update_proposals.sh
```

## Usage

Open and run `swift-proposal-analyzer.playground`.

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

You can now perform different queries or apply filters to the proposal data.

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

## Credits

Created and maintained by [**@jesse_squires**](https://twitter.com/jesse_squires).

## License

Released under an [MIT License](http://opensource.org/licenses/MIT). See `LICENSE` for details.

>**Copyright &copy; 2016-present Jesse Squires.**
