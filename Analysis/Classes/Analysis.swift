//
//  Analysis.swift
//  
//
//  Created by Bas Broek on 11/11/2016.
//
//

import Foundation

enum LengthOption {
  case word
  case sentence
}

struct Analysis {
  typealias Percentage = Double
  typealias Characters = Double
  
  let input: String
  let sentences: [String]
  let words: [String]
  let characters: [Character]
  
  init(of string: String) {
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
  
  static func of(_ string: String) -> Analysis {
    return Analysis(of: string)
  }
  
  func sentenceCount() -> Int {
    return sentences.count
  }
  
  func wordCount(unique: Bool = false) -> Int {
    if unique {
      return _wordOccurrences().keys.count
    } else {
      return words.count
    }
  }
  
  func characterCount(includingSpaces: Bool = true) -> Int {
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
      .map { occurrences[$0] = (occurrences[$0] ?? 0) + 1 }
    return occurrences
  }
  
  private func _characterOccurences(caseSensitive: Bool = false) -> [Character: Int] {
    var occurrences: [Character: Int] = [:]
    characters
      .map { (caseSensitive) ? $0 : Character(String(describing: $0).lowercased()) }
      .map { occurrences[$0] = (occurrences[$0] ?? 0) + 1 }
    return occurrences
  }
  
  func wordOccurrences(caseSensitive: Bool = false) -> [String: Int] {
    return _wordOccurrences(caseSensitive: caseSensitive)
  }
  
  func characterOccurences(caseSensitive: Bool = false) -> [Character: Int] {
    return _characterOccurences(caseSensitive: caseSensitive)
  }
  
  func occurrences(of word: String, caseSensitive: Bool = false) -> Int {
    let word = (caseSensitive) ? word : word.lowercased()
    return _wordOccurrences(caseSensitive: caseSensitive)[word] ?? 0
  }
  
  func occurrences(of character: Character, caseSensitive: Bool = false) -> Int {
    let character = (caseSensitive) ? character : Character(String(describing: character).lowercased())
    return characters
      .map { (caseSensitive) ? $0 : Character(String(describing: $0).lowercased()) }
      .filter { $0 == character }.count
  }
  
  func frequency(of word: String) -> Percentage {
    return Double(occurrences(of: word)) / Double(wordCount()) * 100.0
  }
  
  func frequency(of character: Character, caseSensitive: Bool = false, includingSpaces: Bool = true) -> Percentage {
    return Double(occurrences(of: character, caseSensitive: caseSensitive)) / Double(characterCount(includingSpaces: includingSpaces)) * 100.0
  }
  
  func averageLength(per option: LengthOption) -> Characters {
    let characterCount = self.characterCount(includingSpaces: false)
    switch option {
    case .word:
      return Double(characterCount) / Double(wordCount())
    case .sentence:
      return Double(characterCount) / Double(sentenceCount())
    }
  }
  
  var averageWordsPerSentence: Double {
    return Double(wordCount()) / Double(sentenceCount())
  }
}

extension Analysis: Hashable {
  
  var hashValue: Int {
    return input.hashValue
  }
  
  static func ==(lhs: Analysis, rhs: Analysis) -> Bool {
    return lhs.input == rhs.input
  }
}

extension Analysis: Comparable {
  
  static func <(lhs: Analysis, rhs: Analysis) -> Bool {
    return lhs.input < rhs.input
  }
}

extension Analysis: CustomStringConvertible, CustomDebugStringConvertible {
  
  var description: String {
    return "Analysis(\"\(input)\")"
  }
  
  var debugDescription: String {
    return description
  }
}
