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
  
  // Count
  @IBOutlet var characterCount: UILabel!
  @IBOutlet var excludingSpacesCharactersCount: UILabel!
  @IBOutlet var wordCount: UILabel!
  @IBOutlet var uniqueWordCount: UILabel!
  @IBOutlet var sentenceCount: UILabel!
  
  // Average
  @IBOutlet var averageCharactersPerWord: UILabel!
  @IBOutlet var averageCharactersPerSentence: UILabel!
  @IBOutlet var averageWordsPerSentence: UILabel!
  
  var input: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populate()
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
    
    // Average
    averageCharactersPerWord.text = String(format:"%.2f", analysis.averageCharacters(per: .word))
    averageCharactersPerSentence.text = String(format:"%.2f", analysis.averageCharacters(per: .sentence))
    averageWordsPerSentence.text = String(format:"%.2f", analysis.averageWordsPerSentence)
  }
}
