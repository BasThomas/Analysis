//
//  Analysis.swift
//  
//
//  Created by Bas Broek on 11/11/2016.
//
//

import Foundation

public enum LengthOption {
  case word
  case sentence
}

public struct Analysis {
  public typealias Percentage = Double
  public typealias Characters = Double
  
  public let input: String
  public let sentences: [String]
  public let words: [String]
  public let characters: [Character]
  
  public init(of string: String) {
    input = string
    sentences = input
      .replacingOccurrences(of: "! ", with: "!\n")
      .replacingOccurrences(of: ". ", with: ".\n")
      .replacingOccurrences(of: "? ", with: "?\n").lines
      .filter { !$0.isEmpty }
    words = input.characters
      .split(separator: " ")
      .map(String.init)
      .map { $0.trimmingCharacters(in: CharacterSet.letters.inverted) }
    characters = Array(input.characters)
  }
  
  public func sentenceCount() -> Int {
    return sentences.count
  }
  
  public func wordCount(unique: Bool = false) -> Int {
    if unique {
      return _wordOccurrences().keys.count
    } else {
      return words.count
    }
  }
  
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
      .map { (caseSensitive) ? $0 : Character(String(describing: $0).lowercased()) }
      .forEach { occurrences[$0] = (occurrences[$0] ?? 0) + 1 }
    return occurrences
  }
  
  public func wordOccurrences(caseSensitive: Bool = false) -> [String: Int] {
    return _wordOccurrences(caseSensitive: caseSensitive)
  }
  
  public func characterOccurences(caseSensitive: Bool = false) -> [Character: Int] {
    return _characterOccurences(caseSensitive: caseSensitive)
  }
  
  public func occurrences(of word: String, caseSensitive: Bool = false) -> Int {
    let word = (caseSensitive) ? word : word.lowercased()
    return _wordOccurrences(caseSensitive: caseSensitive)[word] ?? 0
  }
  
  public func occurrences(of character: Character, caseSensitive: Bool = false) -> Int {
    let character = (caseSensitive) ? character : Character(String(describing: character).lowercased())
    return characters
      .map { (caseSensitive) ? $0 : Character(String(describing: $0).lowercased()) }
      .filter { $0 == character }.count
  }
  
  public func frequency(of word: String, caseSensitive: Bool = false) -> Percentage {
    return Double(occurrences(of: word, caseSensitive: caseSensitive)) / Double(wordCount()) * 100.0
  }
  
  public func frequency(of character: Character, caseSensitive: Bool = false, includingSpaces: Bool = true) -> Percentage {
    return Double(occurrences(of: character, caseSensitive: caseSensitive)) / Double(characterCount(includingSpaces: includingSpaces)) * 100.0
  }
  
  public func averageLength(per option: LengthOption) -> Characters {
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
  
  public var averageWordsPerSentence: Double {
    return Double(wordCount()) / Double(sentenceCount())
  }
}

extension Analysis: Hashable {
  
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
  
  public var debugDescription: String {
    return description
  }
}
