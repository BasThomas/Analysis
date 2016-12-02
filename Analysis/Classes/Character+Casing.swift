//
//  Character+Casing.swift
//  Pods
//
//  Created by Bas Broek on 02/12/2016.
//
//

import Foundation

internal extension Character {
  
  func lowercased() -> Character {
    return Character(String(describing: self).lowercased())
  }
  
  func uppercased() -> Character {
    return Character(String(describing: self).uppercased())
  }
}
