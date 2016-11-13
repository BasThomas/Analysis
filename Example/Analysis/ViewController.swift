//
//  ViewController.swift
//  Analysis
//
//  Created by Bas Broek on 11/11/2016.
//  Copyright (c) 2016 Bas Broek. All rights reserved.
//

import UIKit

private let analyseIdentifier = "analyse"

class ViewController: UIViewController {
  
  @IBOutlet var analyseBarButtonItem: UIBarButtonItem!
  @IBOutlet var textView: UITextView! {
    didSet {
      textView.becomeFirstResponder()
      analyseBarButtonItem.isEnabled = !textView.text.isEmpty
    }
  }
}

// MARK: - Text view delegate
extension ViewController: UITextViewDelegate {
  
  func textViewDidChange(_ textView: UITextView) {
    analyseBarButtonItem.isEnabled = !textView.text.isEmpty
  }
}

// MARK: - Actions
extension ViewController {
  
  @IBAction func analyse(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: analyseIdentifier, sender: self)
  }
}

// MARK: - Navigation
extension ViewController {
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destinationViewController = segue.destination as? AnalysisTableViewController else { return }
    destinationViewController.input = textView.text
  }
}
