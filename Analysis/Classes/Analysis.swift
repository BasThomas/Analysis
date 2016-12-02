import Foundation

/// The option to use when calculating average length. This is either `.word` or `.sentence`.
public enum LengthOption {
  case word
  case sentence
}

/// An analysis of a `String`.
public struct Analysis {
  public typealias Percentage = Double
  public typealias Grade = Double
  
  /// The string used to construct the `Analysis`.
  public let input: String
  
  /// The sentences of the `input`.
  public let sentences: [String]
  
  /// The words of the `input`.
  public let words: [String]
  
  /// The characters of the `input`.
  public let characters: [Character]
  
  /// Initializes an `Analysis` object with the given `String`.
  public init(of string: String) {
    input = string
    sentences = input
      .replacingOccurrences(of: "! ", with: "!\n")
      .replacingOccurrences(of: ". ", with: ".\n")
      .replacingOccurrences(of: "? ", with: "?\n").lines
      .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
    words = input.characters
      .split(separator: " ")
      .map(String.init)
      .map { $0.trimmingCharacters(in: CharacterSet.letters.inverted) }
    characters = Array(input.characters)
  }
  
  /// Returns the sentence count of the `input`.
  public func sentenceCount() -> Int {
    return sentences.count
  }
  
  /// Returns the word count of the `input`.
  ///
  /// - Parameter unique: Indicating if words should be
  /// counted regardless of how many times they occur.
  /// Defaults to `false`.
  public func wordCount(unique: Bool = false) -> Int {
    if unique {
      return _wordOccurrences().keys.count
    } else {
      return words.count
    }
  }
  
  /// Returns the total amount of syllables of the `input`.
  public func syllableCount() -> Int {
    return words
      .map { $0.syllables }
      .reduce(0, +)
  }
  
  /// Returns the character count of the `input`.
  ///
  /// - Parameter includingSpaces: Indicating if characters
  /// should be counted including spaces or not.
  /// Defaults to `true`.
  public func characterCount(includingSpaces: Bool = true) -> Int {
    if includingSpaces {
      return characters.count
    } else {
      return characters.filter { $0 != " " }.count
    }
  }
  
  private func _wordOccurrences(caseSensitive: Bool = false) -> [String: Int] {
    var occurrences: [String: Int] = [:]
    words
      .map { (caseSensitive) ? $0 : $0.lowercased() }
      .forEach { occurrences[$0] = (occurrences[$0] ?? 0) + 1 }
    return occurrences
  }
  
  private func _characterOccurences(caseSensitive: Bool = false) -> [Character: Int] {
    var occurrences: [Character: Int] = [:]
    characters
      .map { (caseSensitive) ? $0 : $0.lowercased() }
      .forEach { occurrences[$0] = (occurrences[$0] ?? 0) + 1 }
    return occurrences
  }
  
  /// Returns the word occurrences of the `input`.
  ///
  /// - Parameter caseSensitive: Indicating if words
  /// should be counted regardless of their case sensitivity.
  /// Defaults to `false`.
  ///
  /// - Returns: A `Dictionary` containing the words and their
  /// occurence.
  public func wordOccurrences(caseSensitive: Bool = false) -> [String: Int] {
    return _wordOccurrences(caseSensitive: caseSensitive)
  }
  
  /// Returns the character occurrences of the `input`.
  ///
  /// - Parameter caseSensitive: Indicating if characters
  /// should be counted regardless of their case sensitivity.
  /// Defaults to `false`.
  ///
  /// - Returns: A `Dictionary` containing the characters and their
  /// occurence.
  public func characterOccurences(caseSensitive: Bool = false) -> [Character: Int] {
    return _characterOccurences(caseSensitive: caseSensitive)
  }
  
  /// Returns the amount of occurrences of the specified word.
  ///
  /// - Parameter caseSensitive: Indicating if words
  /// should be counted regardless of their case sensitivity.
  /// Defaults to `false`.
  public func occurrences(of word: String, caseSensitive: Bool = false) -> Int {
    let word = (caseSensitive) ? word : word.lowercased()
    return _wordOccurrences(caseSensitive: caseSensitive)[word] ?? 0
  }
  
  /// Returns the amount of occurrences of the specified `Character`.
  ///
  /// - Parameter caseSensitive: Indicating if words
  /// should be counted regardless of their case sensitivity.
  /// Defaults to `false`.
  public func occurrences(of character: Character, caseSensitive: Bool = false) -> Int {
    let character = (caseSensitive) ? character : character.lowercased()
    return characters
      .map { (caseSensitive) ? $0 : $0.lowercased() }
      .filter { $0 == character }.count
  }
  
  /// Returns the syllables of every unique word.
  public func wordSyllables() -> [String: Int] {
    var syllables: [String: Int] = [:]
    let uniqueWords = Array(_wordOccurrences(caseSensitive: false).keys)
    
    uniqueWords.forEach { syllables[$0] = $0.syllables }
    
    return syllables
  }
  
  /// Returns the frequency of the specified word.
  ///
  /// - Parameter caseSensitive: Indicating if words
  /// should be counted regardless of their case sensitivity.
  /// Defaults to `false`.
  ///
  /// - Returns: A percentage based on the `wordCount()`.
  public func frequency(of word: String, caseSensitive: Bool = false) -> Percentage {
    return Double(occurrences(of: word, caseSensitive: caseSensitive)) / Double(wordCount()) * 100.0
  }
  
  /// Returns the frequency of the specified `Character`.
  ///
  /// - Parameter caseSensitive: Indicating if words
  /// should be counted regardless of their case sensitivity.
  /// Defaults to `false`.
  /// - Parameter includesSpaces: Indicating if characters
  /// should be counted including spaces or not.
  /// Defaults to `true`.
  ///
  /// - Returns: A percentage based on the `characterCount()`.
  public func frequency(of character: Character, caseSensitive: Bool = false, includingSpaces: Bool = true) -> Percentage {
    return Double(occurrences(of: character, caseSensitive: caseSensitive)) / Double(characterCount(includingSpaces: includingSpaces)) * 100.0
  }
  
  /// Returns the average characters of the specified `LengthOption`.
  ///
  /// - Parameter option: The option to calculate the average of.
  /// This is either by `.word` or by `.sentence`.
  public func averageCharacters(per option: LengthOption) -> Double {
    switch option {
    case .word:
      return Double(words.reduce("", +).characters.count) / Double(wordCount())
    case .sentence:
      if sentences.count > 1 {
        return Double(sentences.reduce("", +).characters.count) / Double(sentenceCount())
      } else {
        return Double(characterCount(includingSpaces: true)) / Double(sentenceCount())
      }
    }
  }
  
  /// Returns the average words per sentence.
  public var averageWordsPerSentence: Double {
    return Double(wordCount()) / Double(sentenceCount())
  }
  
  private var _wordsPerSentences: Double {
    return Double(wordCount()) / Double(sentenceCount())
  }
  
  private var _syllablesPerWords: Double {
    return Double(syllableCount()) / Double(wordCount())
  }
  
  /// Returns the Flesch reading ease score.
  ///
  /// - Note: https://en.wikipedia.org/wiki/Flesch–Kincaid_readability_tests#Flesch_reading_ease
  public func fleschReadingEase() -> Percentage {
    return 206.835 - 1.015 * _wordsPerSentences - 84.6 * _syllablesPerWords
  }
  
  /// Returns the Flesch-Kincaid grade level.
  ///
  /// - Note: https://en.wikipedia.org/wiki/Flesch–Kincaid_readability_tests#Flesch.E2.80.93Kincaid_grade_level
  public func fleschKincaidGradeLevel() -> Grade {
    return 0.39 * _wordsPerSentences + 11.8 * _syllablesPerWords - 15.59
  }
}

extension Analysis: Hashable {
  
  /// The `Analysis`’s hash value.
  ///
  /// Hash values are not guaranteed to be equal across
  /// different executions of your program.
  /// Do not save hash values to use during a future execution.
  public var hashValue: Int {
    return input.hashValue
  }
  
  public static func ==(lhs: Analysis, rhs: Analysis) -> Bool {
    return lhs.input == rhs.input
  }
}

extension Analysis: Comparable {
  
  public static func <(lhs: Analysis, rhs: Analysis) -> Bool {
    return lhs.input < rhs.input
  }
}

extension Analysis: CustomStringConvertible, CustomDebugStringConvertible {
  
  public var description: String {
    return "Analysis(\"\(input)\")"
  }
  
  /// A representation of the string that is suitable for debugging.
  public var debugDescription: String {
    return description
  }
}
