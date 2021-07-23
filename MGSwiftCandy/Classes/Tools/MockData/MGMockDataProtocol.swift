//
//  MGMockDataProtocol.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/7/23.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

public protocol MGMockDataProtocol {}
public extension MGMockDataProtocol {
    /// Generate mock data under debug and mockdata macros. So two macros(DEBUG and MOCKDATA) need to be added
    @inline(__always)
    func mockData<T>(_ action: () -> T) {
        #if DEBUG
        #if MOCKDATA
        action()
        #endif
        #endif
    }
}
