import Foundation

public extension String {
  
  /// Returns an alysis of `self`.
  public func analysed() -> Analysis {
    return Analysis(of: self)
  }
  
  internal var lines: [String] {
    var lines: [String] = []
    self.enumerateLines { line, _ in
      lines.append(line)
    }
    return lines
  }
}
