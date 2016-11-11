//
//  String+Analysis.swift
//
//
//  Created by Bas Broek on 11/11/2016.
//
//

import Foundation

public extension String {
  
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
