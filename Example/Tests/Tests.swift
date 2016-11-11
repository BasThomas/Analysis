import UIKit
import XCTest
import Analysis

class Tests: XCTestCase {
  
  let helloWorld1 = Analysis(of: "Hello, world!")
  let helloWorld2 = "Hello, world!".analysed()
  let three = "Hello. Hallo? Hoi!".analysed()
  let a = "a".analysed()
  let z = "z".analysed()
  let repeating = "repeat, repeat, repeat".analysed()
  
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
    XCTAssertLessThan(a < z)
    XCTAssertLessThanOrEqual(a < a)
    XCTAssertLessThanOrEqual(z < z)
    
    XCTAssertGreaterThan(z > a)
    XCTAssertGreaterThanOrEqual(z > z)
    XCTAssertGreaterThanOrEqual(a > a)
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
    
  }
  
  func testCharacterOccurrences() {
    
  }
  
  func testWordFrequency() {
    
  }
  
  func testCharacterFrequency() {
    
  }
  
  func testAverageWordLength() {
    
  }
  
  func testAverageSentenceLength() {
    
  }
  
  func testAverageWordsPerSentence() {
    
  }
}
