//
//  UIViewController+Safari.swift
//  Analysis
//
//  Created by Bas Broek on 02/12/2016.
//  Copyright (c) 2016 Bas Broek. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController: SFSafariViewControllerDelegate {
  
  func open(url: URL, inSafariViewController safariViewController: Bool = true, reader: Bool = false) {
    if !safariViewController {
      if #available(iOS 10.0, *) {
        UIApplication.shared.open(url)
      } else {
        UIApplication.shared.openURL(url)
      }
    } else if #available(iOS 9.0, *) {
      let safariViewController = SFSafariViewController(url: url, entersReaderIfAvailable: reader)
      safariViewController.delegate = self
      present(safariViewController, animated: true)
    }
  }
  
  @available(iOS 9.0, *)
  public func safariViewControllerDidFinish(controller: SFSafariViewController) {
    dismiss(animated: true)
  }
}
