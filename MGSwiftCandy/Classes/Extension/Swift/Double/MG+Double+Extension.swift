//
//  MG+Double+Extension.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/7/4.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

extension MGDouble: MGWrapperEnable {}

// MARK: - Properties
public extension MGWrapper_Mg where MGOriginType == MGDouble {
    /// String value from Double (if applicable).
    ///
    ///    88.88.stringify -> "88.88"
    ///
    var stringify: MGString {
        return MGString(origin)
    }
    
    /// Take an integer no less than this number
    ///
    ///   88.88.ceil -> 89
    ///
    var ceil: MGDouble {
        return Darwin.ceil(origin)
    }
    
    /// Take an integer no greater than this number
    ///
    ///   88.88.ceil -> 88
    ///
    var floor: MGDouble {
        return Darwin.floor(origin)
    }
    
    /// Round to the nearest whole number
    ///
    ///   88.88.round -> 89
    ///   88.45.round -> 88
    ///
    var round: MGDouble {
        return Darwin.round(origin)
    }
    
}
