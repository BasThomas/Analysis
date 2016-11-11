//
//  Dictionary+Sorting.swift
//  
//
//  Created by Bas Broek on 11/11/2016.
//
//

import Foundation

/// The sort option of the dictionary. This is either `.key` or `.value`.
public enum SortOption {
  case key
  case value
}

/// The sort direction used when sorting. This is either `.ascending` or `.descending`.
public enum SortDirection {
  case ascending
  case descending
}

extension Dictionary where Key: Comparable, Value: Comparable {
  
  /// Sorts the dictionary with the specified `SortOption` and `SortDirection`.
  ///
  /// - Parameter option: The sort option to use. This is either by `.key` or by `.value`.
  /// - Parameter direction: The sort direction to use. Defaults to `.ascending`.
  ///
  /// - Returns: The sorted `Dictionary` as an array with `(key: Key, value: Value)` pairs.
  public func sorted(by option: SortOption, direction: SortDirection = .ascending) -> [(key: Key, value: Value)] {
    switch option {
    case .key:
      switch direction {
      case .ascending:
        return sorted { $0.0.key < $0.1.key }
      case .descending:
        return sorted { $0.0.key > $0.1.key }
      }
    case .value:
      switch direction {
      case .ascending:
        return sorted { $0.0.value < $0.1.value }
      case .descending:
        return sorted { $0.0.value > $0.1.value }
      }
    }
  }
}
