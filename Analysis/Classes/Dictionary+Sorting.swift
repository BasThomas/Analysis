//
//  Dictionary+Sorting.swift
//  
//
//  Created by Bas Broek on 11/11/2016.
//
//

import Foundation

public enum SortOption {
  case key
  case value
}

extension Dictionary where Key: Comparable, Value: Comparable {
  
  public func sorted(by option: SortOption, ascending: Bool = true) -> [(key: Key, value: Value)] {
    switch option {
    case .key:
      if ascending {
        return sorted { $0.0.key < $0.1.key }
      } else {
        return sorted { $0.0.key > $0.1.key }
      }
    case .value:
      if ascending {
        return sorted { $0.0.value < $0.1.value }
      } else {
        return sorted { $0.0.value > $0.1.value }
      }
    }
  }
}
