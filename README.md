# Analysis

Analysis is a tool that helps you extract useful information from strings. It calculates the amount of sentences, words, characters, occurrence of words and characters, and more.

## Installation

Analysis is available via CocoaPods.

```ruby
pod 'Analysis', '~> 0.1.0'
```

Then run `pod install`.

## Usage

Analysing a string is very straightforward. You can use any of the two ways to instantiate an `Analysis`:

```swift
import Analysis

let analysis = Analysis(of: "You are awesome, you!")
``` 

or

```swift
import Analysis

let analysis = "You are awesome, you!".analysed()
```

After that, you can get the information you need.

```swift
analysis.sentenceCount() // 1
analysis.wordCount(unique: true) // 4
analysis.characterCount(includingSpaces: false) // 18
analysis.wordOccurrences(caseSensitive: true) // ["You": 1, "are": 1, "awesome", 1, "you": 1]
analysis.wordOccurrences(caseSensitive: false) // ["you": 2, "are": 1, "awesome", 1]
analysis.frequency(of: "you", caseSensitive: false) // 50.0%
analysis.averageLength(per: .word) // 5.33
```

You can also easily sort your occurences via an enhanced sorting method on `Dictionary`.

```swift
analysis.wordOccurrences(caseSensitive: false).sorted(by: .key, ascending: false) // [("are", 1), ("awesome", 1), ("you", 2)]
```

## Contributing

Want to contribute to this project? Great! There's some things that still need work, but definitely also let me know when you encounter any issues, spot a bug, or have a feature request!

Check out the issues for some tasks to get started with.

## License

Analysis is released under an MIT license. See [LICENSE](LICENSE) for more information.
