//
//  AnalysisTests.swift
//  Analysis
//
//  Created by Bas Broek on 11/11/2016.
//  Copyright (c) 2016 Bas Broek. All rights reserved.
//

import UIKit
import XCTest
@testable import Analysis

class AnalysisTests: XCTestCase {
  
  let helloWorld1 = Analysis(of: "Hello, world!")
  let helloWorld2 = "Hello, world!".analysed()
  let three = "Hello. Hallo? Hoi!".analysed()
  let a = "a".analysed()
  let z = "z".analysed()
  let repeating = "repeat, repeat, repeat".analysed()
  let differentSentenceLengths = "Hi. How are you? I am good".analysed()
  let spaces = "Hi.   How are you doing?   ".analysed()
  let face = "Can't feel my face".analysed()
  
  let literal: Analysis = "How are you doing?"
  let nonLiteral = Analysis(of: "How are you doing?")
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testEquality() {
    XCTAssertEqual(helloWorld1, helloWorld2)
    XCTAssertEqual(helloWorld2, helloWorld1)
    
    XCTAssertNotEqual(helloWorld1, three)
    XCTAssertNotEqual(three, helloWorld2)
  }
  
  func testComparability() {
    XCTAssertLessThan(a, z)
    XCTAssertLessThanOrEqual(a, a)
    XCTAssertLessThanOrEqual(z, z)
    
    XCTAssertGreaterThan(z, a)
    XCTAssertGreaterThanOrEqual(z, z)
    XCTAssertGreaterThanOrEqual(a, a)
  }
  
  func testSentenceCount() {
    XCTAssertEqual(three.sentenceCount(), 3)
    XCTAssertEqual(three.sentences.count, 3)
    XCTAssertEqual(spaces.sentenceCount(), 2)
    XCTAssertEqual(spaces.sentences.count, 2)
    XCTAssertEqual(face.sentenceCount(), 1)
    XCTAssertEqual(face.sentences.count, 1)
  }
  
  func testWordCount() {
    XCTAssertEqual(helloWorld1.wordCount(), 2)
    XCTAssertEqual(three.wordCount(), 3)
    XCTAssertEqual(repeating.wordCount(), 3)
    XCTAssertEqual(face.wordCount(), 4)
    
    XCTAssertEqual(helloWorld1.wordCount(unique: true), 2)
    XCTAssertEqual(three.wordCount(unique: true), 3)
    XCTAssertEqual(repeating.wordCount(unique: true), 1)
    XCTAssertEqual(face.wordCount(unique: true), 4)
  }
  
  func testCharacterCount() {
    XCTAssertEqual(helloWorld1.characterCount(), helloWorld1.characters.count)
    XCTAssertEqual(three.characterCount(), three.characters.count)
    XCTAssertEqual(repeating.characterCount(), repeating.characters.count)
    XCTAssertEqual(face.characterCount(), face.characters.count)
    
    XCTAssertEqual(helloWorld1.characterCount(includingSpaces: false), helloWorld1.characters.count - 1)
    XCTAssertEqual(three.characterCount(includingSpaces: false), three.characters.count - 2)
    XCTAssertEqual(repeating.characterCount(includingSpaces: false), repeating.characters.count - 2)
    XCTAssertEqual(face.characterCount(includingSpaces: false), face.characters.count - 3)
  }
  
  func testWordOccurences() {
    XCTAssertEqual(helloWorld1.wordOccurrences(), ["hello": 1, "world": 1])
    XCTAssertEqual(repeating.wordOccurrences(), ["repeat": 3])
    XCTAssertEqual(face.wordOccurrences(), ["can't": 1, "feel": 1, "my": 1, "face": 1])
    
    XCTAssertEqual(helloWorld1.wordOccurrences(caseSensitive: true), ["Hello": 1, "world": 1])
    XCTAssertEqual(repeating.wordOccurrences(caseSensitive: true), ["repeat": 3])
    XCTAssertEqual(face.wordOccurrences(caseSensitive: true), ["Can't": 1, "feel": 1, "my": 1, "face": 1])
    
    XCTAssertEqual(helloWorld1.occurrences(of: "hello"), 1)
    XCTAssertEqual(helloWorld1.occurrences(of: "HELLO"), 1)
    XCTAssertEqual(helloWorld1.occurrences(of: "invalid"), 0)
    XCTAssertEqual(repeating.occurrences(of: "repeat"), 3)
    XCTAssertEqual(repeating.occurrences(of: "re"), 0)
    
    XCTAssertEqual(helloWorld1.occurrences(of: "Hello", caseSensitive: true), 1)
    XCTAssertEqual(helloWorld1.occurrences(of: "HELLO", caseSensitive: true), 0)
    XCTAssertEqual(helloWorld1.occurrences(of: "invalid", caseSensitive: true), 0)
    XCTAssertEqual(repeating.occurrences(of: "repeat", caseSensitive: true), 3)
    XCTAssertEqual(repeating.occurrences(of: "re", caseSensitive: true), 0)
  }
  
  func testCharacterOccurrences() {
    let helloWorldCharacterOccurences: [Character: Int] = ["h": 1, "e": 1, "l": 3, "o": 2, ",": 1, " ": 1, "w": 1, "r": 1, "d": 1, "!": 1]
    let repeatingCharacterOccurences: [Character: Int] = ["r": 3, "e": 6, "p": 3, "a": 3, "t": 3, ",": 2, " ": 2]
    XCTAssertEqual(helloWorld1.characterOccurences(), helloWorldCharacterOccurences)
    XCTAssertEqual(repeating.characterOccurences(), repeatingCharacterOccurences)
    
    let helloWorldCaseSensitiveCharacterOccurences: [Character: Int] = ["H": 1, "e": 1, "l": 3, "o": 2, ",": 1, " ": 1, "w": 1, "r": 1, "d": 1, "!": 1]
    let repeatingCaseSensitiveCharacterOccurences = repeatingCharacterOccurences

    XCTAssertEqual(helloWorld1.characterOccurences(caseSensitive: true), helloWorldCaseSensitiveCharacterOccurences)
    XCTAssertEqual(repeating.characterOccurences(caseSensitive: true), repeatingCaseSensitiveCharacterOccurences)
    
    XCTAssertEqual(helloWorld1.occurrences(of: Character("h")), 1)
    XCTAssertEqual(helloWorld1.occurrences(of: Character("H")), 1)
    XCTAssertEqual(repeating.occurrences(of: Character("a")), 3)
    XCTAssertEqual(repeating.occurrences(of: Character("R")), 3)
    
    XCTAssertEqual(helloWorld1.occurrences(of: Character("h"), caseSensitive: true), 0)
    XCTAssertEqual(helloWorld1.occurrences(of: Character("H"), caseSensitive: true), 1)
    XCTAssertEqual(repeating.occurrences(of: Character("I"), caseSensitive: true), 0)
    XCTAssertEqual(repeating.occurrences(of: Character("r"), caseSensitive: true), 3)
  }
  
  func testWordFrequency() {
    XCTAssertEqual(three.frequency(of: "hello"), 33.3, accuracy: 0.1)
    XCTAssertEqual(three.frequency(of: "HELLO"), 33.3, accuracy: 0.1)
    
    XCTAssertEqual(three.frequency(of: "he"), 0.0)
    XCTAssertEqual(helloWorld1.frequency(of: "hello"), 50.0)
    XCTAssertEqual(repeating.frequency(of: "repeat"), 100.0)
    XCTAssertEqual(repeating.frequency(of: "Repeat"), 100.0)
    
    XCTAssertEqual(three.frequency(of: "Hello", caseSensitive: true), 33.3, accuracy: 0.1)
    
    XCTAssertEqual(three.frequency(of: "hello", caseSensitive: true), 0.0)
    XCTAssertEqual(three.frequency(of: "he", caseSensitive: true), 0.0)
    XCTAssertEqual(three.frequency(of: "HELLO", caseSensitive: true), 0.0)
    XCTAssertEqual(helloWorld1.frequency(of: "hello", caseSensitive: true), 0.0)
    XCTAssertEqual(repeating.frequency(of: "repeat", caseSensitive: true), 100.0)
    XCTAssertEqual(repeating.frequency(of: "Repeat", caseSensitive: true), 0.0)
  }
  
  func testCharacterFrequency() {
    XCTAssertEqual(three.frequency(of: Character("h")), 16.6, accuracy: 0.1)
    XCTAssertEqual(three.frequency(of: Character("H")), 16.6, accuracy: 0.1)
    XCTAssertEqual(three.frequency(of: Character("i")), 5.5, accuracy: 0.1)
    XCTAssertEqual(helloWorld1.frequency(of: Character("h")), 7.7, accuracy: 0.1)
    XCTAssertEqual(repeating.frequency(of: Character("e")), 27.3, accuracy: 0.1)
    XCTAssertEqual(repeating.frequency(of: Character("E")), 27.3, accuracy: 0.1)
    
    XCTAssertEqual(three.frequency(of: Character("H"), caseSensitive: true), 16.6, accuracy: 0.1)
    XCTAssertEqual(three.frequency(of: Character("i"), caseSensitive: true), 5.5, accuracy: 0.1)
    XCTAssertEqual(helloWorld1.frequency(of: Character("e"), caseSensitive: true), 7.7, accuracy: 0.1)
    XCTAssertEqual(repeating.frequency(of: Character("e"), caseSensitive: true), 27.3, accuracy: 0.1)
    
    XCTAssertEqual(three.frequency(of: Character("h"), caseSensitive: true), 0.0)
    XCTAssertEqual(three.frequency(of: Character("h"), caseSensitive: true), 0.0)
    XCTAssertEqual(repeating.frequency(of: Character("T"), caseSensitive: true), 0.0)
  }
  
  func testAverageCharactersPerWord() {
    XCTAssertEqual(three.averageCharacters(per: .word), 4.3, accuracy: 0.1)
    
    XCTAssertEqual(helloWorld1.averageCharacters(per: .word), 5.0)
    XCTAssertEqual(repeating.averageCharacters(per: .word), 6.0)
  }
  
  func testAverageCharactersPerSentence() {
    XCTAssertEqual(three.averageCharacters(per: .sentence), 5.3, accuracy: 0.1)
    
    XCTAssertEqual(helloWorld1.averageCharacters(per: .sentence), 13.0)
    XCTAssertEqual(repeating.averageCharacters(per: .sentence), 22.0)
  }
  
  func testAverageWordsPerSentence() {
    XCTAssertEqual(differentSentenceLengths.averageWordsPerSentence, 2.3, accuracy: 0.1)
    
    XCTAssertEqual(three.averageWordsPerSentence, 1.0)
    XCTAssertEqual(helloWorld1.averageWordsPerSentence, 2.0)
    XCTAssertEqual(repeating.averageWordsPerSentence, 3.0)
  }
  
  func testSyllableCount() {
    XCTAssertEqual(helloWorld1.syllableCount(), 3)
    XCTAssertEqual(helloWorld2.syllableCount(), 3)
    XCTAssertEqual(a.syllableCount(), 1)
    XCTAssertEqual(z.syllableCount(), 1)
    XCTAssertEqual(repeating.syllableCount(), 6)
  }
  
  func testWordSyllables() {
    XCTAssertEqual(helloWorld1.wordSyllables(), ["hello": 2, "world": 1])
    XCTAssertEqual(helloWorld2.wordSyllables(), ["hello": 2, "world": 1])
    XCTAssertEqual(a.wordSyllables(), ["a": 1])
    XCTAssertEqual(z.wordSyllables(), ["z": 1])
    XCTAssertEqual(repeating.wordSyllables(), ["repeat": 2])
  }
  
  func testDescription() {
    XCTAssertEqual(helloWorld1.description, "Analysis(\"\(helloWorld1.input)\")")
    XCTAssertEqual(helloWorld2.description, "Analysis(\"\(helloWorld2.input)\")")
    XCTAssertEqual(a.description, "Analysis(\"\(a.input)\")")
    XCTAssertEqual(z.description, "Analysis(\"\(z.input)\")")
  }
  
  func testDebugDescription() {
    XCTAssertEqual(helloWorld1.debugDescription, dump(helloWorld1.description))
    XCTAssertEqual(helloWorld2.debugDescription, dump(helloWorld2.description))
    XCTAssertEqual(a.debugDescription, dump(a.description))
    XCTAssertEqual(z.debugDescription, dump(z.description))
  }
  
  func testExpressibleByStringLiteral() {
    XCTAssertEqual(literal, nonLiteral)
  }
}
