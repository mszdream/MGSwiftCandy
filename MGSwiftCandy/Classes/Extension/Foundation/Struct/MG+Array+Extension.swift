//
//  MG+Array+Extension.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/25.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

extension MGArray: MGWrapperEnable_One_GenericElement {}

public extension MGWrapper_One_Mg where MGOriginType == MGArray<Element>, Element: Numeric {
    /// Sum of all elements in array.
    /// - Returns: sum of the array's elements.
    func sum() -> Element {
        var total: Element = 0
        for i in 0..<origin.count {
            total += origin[i]
        }
        return total
    }
    
}

// MARK: - property
public extension MGWrapper_One_Mg where MGOriginType == MGArray<Element> {
    /// Sum of all elements in array.
    /// - Returns: sum of the array's elements.
    var length: Int {
        return origin.count
    }
    
    /// A Bool value indicating whether the collection is not empty.
    /// - Returns: Returns a Bool value indicating whether the collection is not empty.
    var isNotEmpty: Bool {
        return !origin.isEmpty
    }
}

// MARK: - method
public extension MGWrapper_One_Mg where MGOriginType == MGArray<Element> {
    /// Element at the given index if it exists.
    /// - Parameter
    ///   - index: index of element.
    /// - Returns: optional element (if exists).
    func item(at index: Int) -> Element? {
        guard origin.startIndex..<origin.endIndex ~= index else { return nil }
        return origin[index]
    }
    
    /// Element at the given index if it exists.
    /// - Parameter
    ///   - index: index of element.
    /// - Returns: optional element (if exists).
    func element(at index: Int) -> Element? {
        return self.item(at: index)
    }
    
    
    /// Insert an element at the beginning of array.
    /// - Parameters:
    ///   - newElement: element to insert.
    mutating func prepend(_ newElement: Element) {
        origin.insert(newElement, at: 0)
    }
}

// MARK: - stack
public extension MGWrapper_One_Mg where MGOriginType == MGArray<Element> {
    /// Insert an element to the end of array.
    /// - Parameters:
    ///   - newElement: element to insert.
    mutating func push(_ newElement: Element) {
        origin.append(newElement)
    }
    
    /// Remove last element from array and return it.
    /// - Returns: last element in array (if applicable).
    @discardableResult mutating func pop() -> Element? {
        return origin.popLast()
    }
}
