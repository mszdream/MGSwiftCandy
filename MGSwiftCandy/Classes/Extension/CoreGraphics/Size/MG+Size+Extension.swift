//
//  MG+Size+Extension.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/6/23.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

extension MGSize: MGWrapperEnable {}

// MARK: - Properties
public extension MGWrapper_Mg where MGOriginType == MGSize {
    /// Calculates the aspect ratio of the size.
    ///
    /// - Returns:
    ///   - The aspect ratio of the size.
    var aspectRatio: CGFloat {
        if origin.height == 0 {
            return 1
        }
        
        return origin.width / origin.height
    }

    /// Finds an new size by aconstrained size and its aspect ratio.
    ///
    /// - Parameters:
    ///   - size: The contraining size.
    /// - Returns:
    ///   - A new size that fits inside the contraining size with the same aspect ratio.
    func constrained(by size: MGSize) -> MGSize {
        let aspectWidth = round(aspectRatio * size.height)
        let aspectHeight = round(size.width / aspectRatio)
        
        if aspectWidth > size.width {
            return MGSize(width: size.width, height: aspectHeight)
        } else {
            return MGSize(width: aspectWidth, height: size.height)
        }
    }
    
    /// Finds a new size filling the given size while keeping the aspect ratio.
    ///
    /// - Parameters:
    ///   - size: The contraining size.
    /// - Returns:
    ///   - A new size that fills the contraining size keeping the same aspect ratio.
    func filling(by size: CGSize) -> CGSize {
        let aspectWidth = round(aspectRatio * size.height)
        let aspectHeight = round(size.width / aspectRatio)
        
        if aspectWidth > size.width {
            return CGSize(width: aspectWidth, height: size.height)
        } else {
            return CGSize(width: size.width, height: aspectHeight)
        }
    }
    
}
