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
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testEquality() {
    let analysis = Analysis(of: "You are awesome, you!")
    print(analysis.wordOccurrences(caseSensitive: false).sorted(by: .key, ascending: true))
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
  }
  
  func testWordCount() {
    XCTAssertEqual(helloWorld1.wordCount(), 2)
    XCTAssertEqual(three.wordCount(), 3)
    XCTAssertEqual(repeating.wordCount(), 3)
    
    XCTAssertEqual(helloWorld1.wordCount(unique: true), 2)
    XCTAssertEqual(three.wordCount(unique: true), 3)
    XCTAssertEqual(repeating.wordCount(unique: true), 1)
  }
  
  func testCharacterCount() {
    XCTAssertEqual(helloWorld1.characterCount(), helloWorld1.characters.count)
    XCTAssertEqual(three.characterCount(), three.characters.count)
    XCTAssertEqual(repeating.characterCount(), repeating.characters.count)
    
    XCTAssertEqual(helloWorld1.characterCount(includingSpaces: false), helloWorld1.characters.count - 1)
    XCTAssertEqual(three.characterCount(includingSpaces: false), three.characters.count - 2)
    XCTAssertEqual(repeating.characterCount(includingSpaces: false), repeating.characters.count - 2)
  }
  
  func testWordOccurences() {
    print(helloWorld1.words)
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
    XCTAssertEqualWithAccuracy(three.frequency(of: "hello"), 33.3, accuracy: 0.1)
    XCTAssertEqualWithAccuracy(three.frequency(of: "HELLO"), 33.3, accuracy: 0.1)
    
    XCTAssertEqual(three.frequency(of: "he"), 0.0)
    XCTAssertEqual(helloWorld1.frequency(of: "hello"), 50.0)
    XCTAssertEqual(repeating.frequency(of: "repeat"), 100.0)
    XCTAssertEqual(repeating.frequency(of: "Repeat"), 100.0)
    
    XCTAssertEqualWithAccuracy(three.frequency(of: "Hello", caseSensitive: true), 33.3, accuracy: 0.1)
    
    XCTAssertEqual(three.frequency(of: "hello", caseSensitive: true), 0.0)
    XCTAssertEqual(three.frequency(of: "he", caseSensitive: true), 0.0)
    XCTAssertEqual(three.frequency(of: "HELLO", caseSensitive: true), 0.0)
    XCTAssertEqual(helloWorld1.frequency(of: "hello", caseSensitive: true), 0.0)
    XCTAssertEqual(repeating.frequency(of: "repeat", caseSensitive: true), 100.0)
    XCTAssertEqual(repeating.frequency(of: "Repeat", caseSensitive: true), 0.0)
  }
  
  func testCharacterFrequency() {
    XCTAssertEqualWithAccuracy(three.frequency(of: Character("h")), 16.6, accuracy: 0.1)
    XCTAssertEqualWithAccuracy(three.frequency(of: Character("H")), 16.6, accuracy: 0.1)
    XCTAssertEqualWithAccuracy(three.frequency(of: Character("i")), 5.5, accuracy: 0.1)
    XCTAssertEqualWithAccuracy(helloWorld1.frequency(of: Character("h")), 7.7, accuracy: 0.1)
    XCTAssertEqualWithAccuracy(repeating.frequency(of: Character("e")), 27.3, accuracy: 0.1)
    XCTAssertEqualWithAccuracy(repeating.frequency(of: Character("E")), 27.3, accuracy: 0.1)
    
    XCTAssertEqualWithAccuracy(three.frequency(of: Character("H"), caseSensitive: true), 16.6, accuracy: 0.1)
    XCTAssertEqualWithAccuracy(three.frequency(of: Character("i"), caseSensitive: true), 5.5, accuracy: 0.1)
    XCTAssertEqualWithAccuracy(helloWorld1.frequency(of: Character("e"), caseSensitive: true), 7.7, accuracy: 0.1)
    XCTAssertEqualWithAccuracy(repeating.frequency(of: Character("e"), caseSensitive: true), 27.3, accuracy: 0.1)
    
    XCTAssertEqual(three.frequency(of: Character("h"), caseSensitive: true), 0.0)
    XCTAssertEqual(three.frequency(of: Character("h"), caseSensitive: true), 0.0)
    XCTAssertEqual(repeating.frequency(of: Character("T"), caseSensitive: true), 0.0)
  }
  
  func testAverageWordLength() {
    XCTAssertEqualWithAccuracy(three.averageLength(per: .word), 4.3, accuracy: 0.1)
    
    XCTAssertEqual(helloWorld1.averageLength(per: .word), 5.0)
    XCTAssertEqual(repeating.averageLength(per: .word), 6.0)
  }
  
  func testAverageSentenceLength() {
    XCTAssertEqualWithAccuracy(three.averageLength(per: .sentence), 5.3, accuracy: 0.1)
    
    XCTAssertEqual(helloWorld1.averageLength(per: .sentence), 13.0)
    XCTAssertEqual(repeating.averageLength(per: .sentence), 22.0)
  }
  
  func testAverageWordsPerSentence() {
    XCTAssertEqualWithAccuracy(differentSentenceLengths.averageWordsPerSentence, 2.3, accuracy: 0.1)
    
    XCTAssertEqual(three.averageWordsPerSentence, 1.0)
    XCTAssertEqual(helloWorld1.averageWordsPerSentence, 2.0)
    XCTAssertEqual(repeating.averageWordsPerSentence, 3.0)
  }
}
