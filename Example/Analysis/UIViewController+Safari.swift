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
  
  func open(
    url: URL,
    inSafariViewController safariViewController: Bool = true,
    reader: Bool = false,
    application: UIApplication = .shared
  ) {
    func openSafari(with url: URL) {
      if #available(iOS 10.0, *) {
        application.open(url)
      } else {
        application.openURL(url)
      }
    }
    if safariViewController == false {
      openSafari(with: url)
    } else if #available(iOS 9.0, *) {
      let safariViewController = SFSafariViewController(
        url: url,
        entersReaderIfAvailable: reader
      )
      safariViewController.delegate = self
      present(safariViewController, animated: true)
    } else {
      openSafari(with: url)
    }
  }
  
  @available(iOS 9.0, *)
  public func safariViewControllerDidFinish(controller: SFSafariViewController) {
    dismiss(animated: true)
  }
}
