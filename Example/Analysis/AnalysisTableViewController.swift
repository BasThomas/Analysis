//
//  AnalysisTableViewController.swift
//  Analysis
//
//  Created by Bas Broek on 13/11/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Analysis

class AnalysisTableViewController: UITableViewController {
  
  fileprivate let readingEaseIndexPath = IndexPath(row: 0, section: 2)
  fileprivate let gradeLevelIndexPath = IndexPath(row: 1, section: 2)
  
  // Count
  @IBOutlet var characterCount: UILabel!
  @IBOutlet var excludingSpacesCharactersCount: UILabel!
  @IBOutlet var wordCount: UILabel!
  @IBOutlet var uniqueWordCount: UILabel!
  @IBOutlet var sentenceCount: UILabel!
  @IBOutlet var syllableCount: UILabel!
  
  // Average
  @IBOutlet var averageCharactersPerWord: UILabel!
  @IBOutlet var averageCharactersPerSentence: UILabel!
  @IBOutlet var averageWordsPerSentence: UILabel!
  
  // Flesch-Kincaid
  @IBOutlet var fleschReadingEase: UILabel!
  @IBOutlet var fleschKincaidGradeLevel: UILabel!
  
  var input: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populate()
  }
}

// MARK: - UITableViewDelegate
extension AnalysisTableViewController {
  
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    switch indexPath {
    case readingEaseIndexPath:
      guard let url = URL(string: "https://en.wikipedia.org/wiki/Flesch-Kincaid_readability_tests#Flesch_reading_ease") else { return }
      open(url: url, reader: true)
    case gradeLevelIndexPath:
      guard let url = URL(string: "https://en.wikipedia.org/wiki/Flesch-Kincaid_readability_tests#Flesch.E2.80.93Kincaid_grade_level") else { return }
      open(url: url, reader: true)
    default:
      break
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

// MARK: - Private
private extension AnalysisTableViewController {
  
  func populate() {
    guard let input = input else { fatalError("No input from previous view.") }
    let analysis = Analysis(of: input)
    
    // Count
    characterCount.text = String(describing: analysis.characterCount())
    excludingSpacesCharactersCount.text = String(describing: analysis.characterCount(includingSpaces: false))
    wordCount.text = String(describing: analysis.wordCount())
    uniqueWordCount.text = String(describing: analysis.wordCount(unique: true))
    sentenceCount.text = String(describing: analysis.sentenceCount())
    syllableCount.text = String(describing: analysis.syllableCount())
    
    // Average
    averageCharactersPerWord.text = String(format: "%.2f", analysis.averageCharacters(per: .word))
    averageCharactersPerSentence.text = String(format: "%.2f", analysis.averageCharacters(per: .sentence))
    averageWordsPerSentence.text = String(format: "%.2f", analysis.averageWordsPerSentence)
    
    // Flesch-Kincaid
    fleschReadingEase.text = String(format: "%.2f", analysis.fleschReadingEase())
    fleschKincaidGradeLevel.text = String(format: "%.2f", analysis.fleschKincaidGradeLevel())
  }
}
