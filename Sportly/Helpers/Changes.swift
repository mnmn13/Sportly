//
//  Changes.swift
//  Sportly
//
//  Created by MN on 30.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import UIKit

// MARK: Static Instances

extension Changes {
    static let none = Changes(inserted: [], removed: [], updated: [], insertedSection: [], removedSection: [], scrollInfo: nil)
}

struct Changes: Equatable {
    
    // MARK: Properties
    
    private(set) var inserted: [IndexPath]
    private(set) var removed: [IndexPath]
    private(set) var updated: [IndexPath]
    
    private(set) var insertedSection: IndexSet = []
    private(set) var removedSection: IndexSet = []

    let scrollInfo: ScrollInfo?
    
    var isEmpty: Bool { self == .none }
    
    // MARK: SectionAction
    
    enum SectionAction {
        case insert
        case remove
    }
    
    // MARK: Initializers
    
    init(inserted: [IndexPath] = [],
         removed: [IndexPath] = [],
         updated: [IndexPath] = [],
         insertedSection: IndexSet = [],
         removedSection: IndexSet = [],
         scrollInfo: ScrollInfo? = nil) {
        self.inserted = inserted
        self.removed = removed
        self.updated = updated
        self.scrollInfo = scrollInfo
        self.insertedSection = insertedSection
        self.removedSection = removedSection
        if inserted.isEmpty && removed.isEmpty && updated.isEmpty && insertedSection.isEmpty && removedSection.isEmpty && scrollInfo == nil { return }
//        Logger.shared.log.debug(self)
    }
    
    init(inserted: [IndexPath] = [],
         removed: [IndexPath] = [],
         updated: [IndexPath] = [],
         insertedSection: [Int] = [],
         removedSection: [Int] = [],
         scrollInfo: ScrollInfo? = nil) {
        
        self.init(inserted: inserted,
                  removed: removed,
                  updated: updated,
                  insertedSection: IndexSet(insertedSection),
                  removedSection: IndexSet(removedSection),
                  scrollInfo: scrollInfo)
    }
    
    init(inserted: [Int] = [],
         removed: [Int] = [],
         updated: [Int] = [],
         section: Int = .zero,
         sectionAction: SectionAction? = nil,
         scrollInfo: ScrollInfo? = nil) {
        
        var insertedSection: [Int] = []
        var removedSection: [Int] = []
        
        switch sectionAction {
        case .insert: insertedSection = [section]
        case .remove: removedSection = [section]
        case .none: break
        }
        
        self.init(inserted: inserted.createIndexPaths(for: section),
                  removed: removed.createIndexPaths(for: section),
                  updated: updated.createIndexPaths(for: section),
                  insertedSection: insertedSection,
                  removedSection: removedSection,
                  scrollInfo: scrollInfo)
    }
    
    init(inserted: Set<Int> = [],
         removed: Set<Int> = [],
         updated: Set<Int> = [],
         section: Int = .zero,
         sectionAction: SectionAction? = nil,
         scrollInfo: ScrollInfo? = nil) {
        
        var insertedSection: [Int] = []
        var removedSection: [Int] = []
        
        switch sectionAction {
        case .insert: insertedSection = [section]
        case .remove: removedSection = [section]
        case .none: break
        }
        
        self.init(inserted: inserted.createIndexPaths(for: section),
                  removed: removed.createIndexPaths(for: section),
                  updated: updated.createIndexPaths(for: section),
                  insertedSection: insertedSection,
                  removedSection: removedSection,
                  scrollInfo: scrollInfo)
    }
    
    init(inserted: Range<Int>? = nil,
         removed: Range<Int>? = nil,
         updated: Range<Int>? = nil,
         section: Int = 0,
         sectionAction: SectionAction? = nil,
         scrollInfo: ScrollInfo? = nil) {
        
        var insertedArray: [Int] = []
        if let inserted {
            insertedArray = .init(inserted)
        }
        
        var removedArray: [Int] = []
        if let removed {
            removedArray = .init(removed)
        }
        
        var updatedArray: [Int] = []
        if let updated {
            updatedArray = .init(updated)
        }
        
        self.init(inserted: insertedArray,
                  removed: removedArray,
                  updated: updatedArray,
                  section: section,
                  sectionAction: sectionAction,
                  scrollInfo: scrollInfo)
    }
    
    init(inserted: Int? = nil,
         removed: Int? = nil,
         updated: Int? = nil,
         section: Int = 0,
         sectionAction: SectionAction? = nil,
         scrollInfo: ScrollInfo? = nil) {
        
        var insertedArray: [Int] = []
        if let inserted {
            insertedArray = [inserted]
        }
        
        var removedArray: [Int] = []
        if let removed {
            removedArray = [removed]
        }
        
        var updatedArray: [Int] = []
        if let updated {
            updatedArray = [updated]
        }
        
        self.init(inserted: insertedArray,
                  removed: removedArray,
                  updated: updatedArray,
                  section: section,
                  sectionAction: sectionAction,
                  scrollInfo: scrollInfo)
    }
    
    init(inserted: IndexPath? = nil,
         removed: IndexPath? = nil,
         updated: IndexPath? = nil,
         insertedSection: [Int] = [],
         removedSection: [Int] = [],
         scrollInfo: ScrollInfo? = nil) {
        
        var insertedArray: [IndexPath] = []
        if let inserted {
            insertedArray = [inserted]
        }
        
        var removedArray: [IndexPath] = []
        if let removed {
            removedArray = [removed]
        }
        
        var updatedArray: [IndexPath] = []
        if let updated {
            updatedArray = [updated]
        }
        
        self.init(inserted: insertedArray,
                  removed: removedArray,
                  updated: updatedArray,
                  insertedSection: insertedSection,
                  removedSection: removedSection,
                  scrollInfo: scrollInfo)
    }
    
    init<T: Hashable>(new: [T],
                      old: [T],
                      section: Int = .zero,
                      sectionAction: SectionAction? = nil,
                      scrollInfo: ScrollInfo? = nil) {
        
        var removed = Set<Int>()
        var inserted = Set<Int>()
        let difference = new.difference(from: old).inferringMoves()
        
        difference.forEach {
            switch $0 {
            case .remove(offset: let index, element: _, associatedWith: _):
                removed.insert(index)
            case .insert(offset: let index, element: _, associatedWith: _):
                inserted.insert(index)
            }
        }
        
        let insertedSet = inserted.subtracting(removed)
        let removedSet = removed.subtracting(inserted)
        let updatedSet = inserted.intersection(removed)
        
        self.init(inserted: insertedSet,
                  removed: removedSet,
                  updated: updatedSet,
                  section: section,
                  sectionAction: sectionAction,
                  scrollInfo: scrollInfo)
    }
    
    init<T: Hashable>(new: [[T]],
                      old: [[T]],
                      scrollInfo: ScrollInfo? = nil) {
        var removed = Set<Int>()
        var inserted = Set<Int>()
        let difference = new.difference(from: old).inferringMoves()
        
        difference.forEach {
            switch $0 {
            case .remove(offset: let index, element: _, associatedWith: _):
                removed.insert(index)
            case .insert(offset: let index, element: _, associatedWith: _):
                inserted.insert(index)
            }
        }
        
        let insertedSections = inserted.subtracting(removed)
        let insertedSectionIndexSet: IndexSet = .init(insertedSections)
        var insertedArray = insertedSections.flatMap { new[$0].indices.createIndexPaths(for: $0) }
        
        let removedSections = removed.subtracting(inserted)
        let removedSectionIndexSet: IndexSet = .init(removedSections)
        var removedArray = removedSections.flatMap { old[$0].indices.createIndexPaths(for: $0) }
        
        let updatedSections = removed.intersection(inserted)
        var updatedArray: [IndexPath] = []
        updatedSections.forEach { section in
            
            let newItems = new[section]
            let oldItems = old[section]
            
            var removed = Set<IndexPath>()
            var inserted = Set<IndexPath>()
            let difference = newItems.difference(from: oldItems).inferringMoves()
            
            difference.forEach {
                switch $0 {
                case .remove(offset: let index, element: _, associatedWith: _):
                    removed.insert(IndexPath(item: index, section: section))
                case .insert(offset: let index, element: _, associatedWith: _):
                    inserted.insert(IndexPath(item: index, section: section))
                }
            }
            
            let insertedSet = inserted.subtracting(removed)
            insertedArray.append(contentsOf: insertedSet)
            
            let removedSet = removed.subtracting(inserted)
            removedArray.append(contentsOf: removedSet)
            
            let updatedSet = inserted.intersection(removed)
            updatedArray.append(contentsOf: updatedSet)
        }
        
        self.init(inserted: insertedArray,
                  removed: removedArray,
                  updated: updatedArray,
                  insertedSection: insertedSectionIndexSet,
                  removedSection: removedSectionIndexSet,
                  scrollInfo: scrollInfo)
    }
    
    // MARK: Scroll Info
    
    struct ScrollInfo: Equatable {
        let indexPath: IndexPath
        let animated: Bool
        init(indexPath: IndexPath, animated: Bool = true) {
            self.indexPath = indexPath
            self.animated = animated
        }
    }
}

extension Collection where Element == Int {
    
    // MARK: IndexPath Routine
    
    func createIndexPaths(for section: Int = 0) -> [IndexPath] {
        return self.map { IndexPath(item: $0, section: section) }
    }
    
    func createSectionIndexPaths() -> [IndexPath] {
        return self.map { IndexPath(item: 0, section: $0) }
    }
}
