import Foundation

internal extension Character {
  
  func lowercased() -> Character {
    return Character(String(describing: self).lowercased())
  }
  
  func uppercased() -> Character {
    return Character(String(describing: self).uppercased())
  }
}
