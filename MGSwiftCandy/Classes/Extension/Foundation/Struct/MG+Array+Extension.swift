//
//  MG+Array+Extension.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/25.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

extension MGArray: MGWrapperEnable_One_GenericElement {}

// MARK: - property
public extension MGWrapper_One_Mg where MGOriginType == MGArray<Element> {
    /// Sum of all elements in array.
    ///
    /// - Returns: The count of the array's elements.
    var length: MGInt {
        return origin.count
    }
    
    /// A Bool value indicating whether the collection is not empty.
    ///
    /// - Returns: Returns a Bool value indicating whether the collection is not empty.
    var isNotEmpty: MGBool {
        return !origin.isEmpty
    }
}

// MARK: - method
public extension MGWrapper_One_Mg where MGOriginType == MGArray<Element> {
    /// Insert an element at the ending of array.
    ///
    /// - Parameters:
    ///   - newElement: Element to insert.
    mutating func apend(_ newElement: Element) {
        origin.append(newElement)
    }
    
    /// Insert an element at the beginning of array.
    ///
    /// - Parameters:
    ///   - newElement: Element to insert.
    mutating func preApend(_ newElement: Element) {
        origin.insert(newElement, at: 0)
    }
    
    /// Insert an element at anywhere
    ///
    /// - Parameters:
    ///   - index: Where the element is inserted
    ///   - newElement: Element to insert.
    mutating func insert(_ newElement: Element, at index: MGInt) {
        guard origin.startIndex...origin.endIndex ~= index else { return }
        origin.insert(newElement, at: index)
    }
    
    /// Element at the given index if it exists.
    ///
    /// - Parameter
    ///   - index: The index of element.
    /// - Returns: Optional element (if exists).
    func element(at index: MGInt) -> Element? {
        return self.item(at: index)
    }
    
    /// Subscript operator support
    ///
    /// - Parameter
    ///   - index: The Index of element.
    subscript(_ index: MGInt) -> Element? {
        get { return self.item(at: index) }
        set {
            guard let element = newValue else {
                return
            }
            
            self.insert(element, at: index)
        }
    }
    
    /// Element at the given index if it exists.
    ///
    /// - Parameter
    ///   - index: The index of the element.
    /// - Returns: Optional element (if exists).
    func item(at index: MGInt) -> Element? {
        guard origin.startIndex..<origin.endIndex ~= index else { return nil }
        return origin[index]
    }
    
}

// MARK: - stack
public extension MGWrapper_One_Mg where MGOriginType == MGArray<Element> {
    /// Insert an element to the end of array.
    ///
    /// - Parameters:
    ///   - newElement: Element to insert.
    mutating func push(_ newElement: Element) {
        origin.append(newElement)
    }
    
    /// Remove last element from array and return it.
    ///
    /// - Returns: Last element in array (if applicable).
    @discardableResult mutating func pop() -> Element? {
        return origin.popLast()
    }
}

// MARK: - extension method
public extension MGWrapper_One_Mg where MGOriginType == MGArray<Element>, Element: Numeric {
    /// Sum of all elements in array.
    ///
    /// - Returns: The sum of the array's elements.
    func sum() -> Element {
        var total: Element = 0
        for i in 0..<origin.count {
            total += origin[i]
        }
        return total
    }
    
}
