//
//  ThreadSafeArray.swift
//  Sportly
//
//  Created by MN on 11.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

class ThreadSafeArray<T> {
    private var array: [T] = []
    private let lock = NSRecursiveLock()

    var count: Int {
        lock.lock()
        defer { lock.unlock() }
        return array.count
    }

    func append(_ element: T) {
        lock.lock()
        defer { lock.unlock() }
        array.append(element)
    }

    func append(contentsOf elements: [T]) {
        lock.lock()
        defer { lock.unlock() }
        array.append(contentsOf: elements)
    }

    subscript(index: Int) -> T {
        get {
            lock.lock()
            defer { lock.unlock() }
            return array[index]
        }
        set {
            lock.lock()
            defer { lock.unlock() }
            array[index] = newValue
        }
    }

    var allElements: [T] {
        lock.lock()
        defer { lock.unlock() }
        return array
    }
}
