//
//  GlobalFunctions.swift
//  Sportly
//
//  Created by MN on 30.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

func calculateCellIndex<T: Equatable>(forElement element: T, inItems items: [T]) -> Int? {
    guard let index = items.firstIndex(where: { $0 == element }) else { return nil }
    return index
}
