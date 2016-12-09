//
//  CharacterCasingTests.swift
//  Analysis
//
//  Created by Bas Broek on 09/12/2016.
//  Copyright (c) 2016 Bas Broek. All rights reserved.
//

import XCTest
@testable import Analysis

class CharacterCasingTests: XCTestCase {
  
  let aLowercase: Character = "a"
  let aUppercase: Character = "A"
  let bLowercase: Character = "b"
  let bUppercase: Character = "B"
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testLowercaseCharacters() {
    XCTAssertEqual(aUppercase.lowercased(), aLowercase)
    XCTAssertEqual(aLowercase.lowercased(), aLowercase)
    XCTAssertEqual(bUppercase.lowercased(), bLowercase)
    XCTAssertEqual(bLowercase.lowercased(), bLowercase)
    
    XCTAssertNotEqual(aUppercase.lowercased(), aUppercase)
    XCTAssertNotEqual(aLowercase.lowercased(), aUppercase)
    XCTAssertNotEqual(bUppercase.lowercased(), bUppercase)
    XCTAssertNotEqual(bLowercase.lowercased(), bUppercase)
  }
  
  func testUppercaseCharacters() {
    XCTAssertEqual(aUppercase.uppercased(), aUppercase)
    XCTAssertEqual(aLowercase.uppercased(), aUppercase)
    XCTAssertEqual(bUppercase.uppercased(), bUppercase)
    XCTAssertEqual(bLowercase.uppercased(), bUppercase)
    
    XCTAssertNotEqual(aUppercase.uppercased(), aLowercase)
    XCTAssertNotEqual(aLowercase.uppercased(), aLowercase)
    XCTAssertNotEqual(bUppercase.uppercased(), bLowercase)
    XCTAssertNotEqual(bLowercase.uppercased(), bLowercase)
  }
}
