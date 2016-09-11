# swift-proposal-analyzer

*An analysis of Swift Evolution proposals*

## Requirements

- Xcode 8
- Swift 3.0

## Setup

The [`swift-evolution`](https://github.com/apple/swift-evolution) repo is a [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

### Cloning

```bash
$ git clone https://github.com/jessesquires/swift-proposal-analyzer.git
$ cd swift-proposal-analyzer/
$ git submodule init
$ ./update_proposals.sh
```

### Updating proposals

Pulls the latest from [`swift-evolution`](https://github.com/apple/swift-evolution) and adds them to the playground.

```bash
$ ./update_proposals.sh
```

### Usage

Open `swift-proposal-analyzer.playground`.

After parsing completes, you'll have an array of `Proposal` types. 

```swift
public struct Proposal {
    public let title: String
    public let seNumber: String
    public let fileName: String
    public let authors: [String]
    public let status: String
}
```

## License

Released under an [MIT License][mitLink]. See `LICENSE` for details.
