//
//  SyllableCounter.swift
//
//  Created by Warren Freitag on 2/14/16.
//  Copyright © 2016 Warren Freitag. All rights reserved.
//  Licensed under the Apache 2.0 License.
//
//  Adapted from a Java implementation created by Hugo "m09" Mougard.
//  https://github.com/m09/syllable-counter
//

import UIKit

public class SyllableCounter {
  
  // MARK: - Shared instance
  
  public static let shared = SyllableCounter()
  
  // MARK: - Private properties
  
  private var exceptions: [String: Int] = [
    "brutes": 1,
    "chummed": 1,
    "flapped": 1,
    "foamed": 1,
    "gaped": 1,
    "h'm": 1,
    "lb": 1,
    "mimes": 1,
    "ms": 1,
    "peeped": 1,
    "sheered": 1,
    "st": 1,
    "queue": 1,
    "none": 1,
    "leaves": 1,
    "awesome": 2,
    "60": 2,
    "capered": 2,
    "caressed": 2,
    "clattered": 2,
    "deafened": 2,
    "dr": 2,
    "effaced": 2,
    "effaces": 2,
    "fringed": 2,
    "greyish": 2,
    "jr": 2,
    "mangroves": 2,
    "messieurs": 2,
    "motioned": 2,
    "moustaches": 2,
    "mr": 2,
    "mrs": 2,
    "pencilled": 2,
    "poleman": 2,
    "quivered": 2,
    "reclined": 2,
    "shivered": 2,
    "sidespring": 2,
    "slandered": 2,
    "sombre": 2,
    "sr": 2,
    "stammered": 2,
    "suavely": 2,
    "tottered": 2,
    "trespassed": 2,
    "truckle": 2,
    "unstained": 2,
    "therefore": 2,
    "businesses": 3,
    "bottleful": 3,
    "discoloured": 3,
    "disinterred": 3,
    "hemispheres": 3,
    "manoeuvred": 3,
    "sepulchre": 3,
    "shamefully": 3,
    "unexpressed": 3,
    "veriest": 3,
    "wyoming": 3,
    "etc": 4,
    "sailmaker": 4,
    "satiated": 4,
    "sententiously": 4,
    "particularized": 5,
    "unostentatious": 5,
    "propitiatory": 6,
  ]
  
  private var addSyllables: [NSRegularExpression]!
  private var subSyllables: [NSRegularExpression]!
  
  private let vowels: Set<Character> = ["a", "e", "i", "o", "u", "y"]
  
  // MARK: - Error enum
  
  private enum SyllableCounterError: Error {
    case badRegex(String)
    case badExceptionsData(String)
  }
  
  // MARK: - Constructors
  
  public init() {
    do {
      try populateAddSyllables()
      try populateSubSyllables()
    }
    catch SyllableCounterError.badRegex(let pattern) {
      print("Bad Regex pattern: \(pattern)")
    }
    catch SyllableCounterError.badExceptionsData(let info) {
      print("Problem parsing exceptions dataset: \(info)")
    }
    catch {
      print("An unexpected error occured while initializing the syllable counter.")
    }
  }
  
  // MARK: - Setup
  
  private func populateAddSyllables() throws {
    try addSyllables = buildRegexes(forPatterns: [
      "ia", "riet", "dien", "iu", "io", "ii",
      "[aeiouy]bl$", "mbl$", "tl$", "sl$", "[aeiou]{3}",
      "^mc", "ism$", "(.)(?!\\1)([aeiouy])\\2l$", "[^l]llien", "^coad.",
      "^coag.", "^coal.", "^coax.", "(.)(?!\\1)[gq]ua(.)(?!\\2)[aeiou]", "dnt$",
      "thm$", "ier$", "iest$", "[^aeiou][aeiouy]ing$"])
  }
  
  private func populateSubSyllables() throws {
    try subSyllables = buildRegexes(forPatterns: [
      "cial", "cian", "tia", "cius", "cious",
      "gui", "ion", "iou", "sia$", ".ely$",
      "ves$", "geous$", "gious$", "[^aeiou]eful$", ".red$"])
  }
  
  private func buildRegexes(forPatterns patterns: [String]) throws -> [NSRegularExpression] {
    return try patterns.map { pattern -> NSRegularExpression in
      do {
        let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive, .anchorsMatchLines])
        return regex
      }
      catch {
        throw SyllableCounterError.badRegex(pattern)
      }
    }
  }
  
  // MARK: - Public methods
  
  internal func count(word: String) -> Int {
    if word.characters.count <= 1 {
      return word.characters.count
    }
    
    var mutatedWord = word.lowercased(with: Locale(identifier: "en_US")).trimmingCharacters(in: .punctuationCharacters)
    
    if let exceptionValue = exceptions[mutatedWord] {
      return exceptionValue
    }
    
    if mutatedWord.characters.last == "e" {
      mutatedWord = String(mutatedWord.characters.dropLast())
    }
    
    var count = 0
    var previousIsVowel = false
    
    for character in mutatedWord.characters {
      let isVowel = vowels.contains(character)
      if isVowel && !previousIsVowel {
        count += 1
      }
      previousIsVowel = isVowel
    }
    
    for pattern in addSyllables {
      let matches = pattern.matches(in: mutatedWord, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: mutatedWord.characters.count))
      if !matches.isEmpty {
        count += 1
      }
    }
    
    for pattern in subSyllables {
      let matches = pattern.matches(in: mutatedWord, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: mutatedWord.characters.count))
      if !matches.isEmpty {
        count -= 1
      }
    }
    
    return (count > 0) ? count : 1
  }
}

extension String {
  
  internal var syllables: Int {
    return SyllableCounter.shared.count(word: self)
  }
}
