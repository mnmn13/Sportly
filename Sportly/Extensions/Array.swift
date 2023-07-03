//
//  Array.swift
//  Sportly
//
//  Created by MN on 11.05.2023.
//

import Foundation

extension Array {
    func mapToSet<T: Hashable>(_ transform: (Element) -> T) -> Set<T> {
        var result = Set<T>()
        for item in self {
            result.insert(transform(item))
        }
        return result
    }
}
