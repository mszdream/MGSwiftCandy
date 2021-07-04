//
//  MG+Float+Extension.swift
//  MGSwiftCandy
//
//  Created by msz on 2021/7/4.
//

extension MGFloat: MGWrapperEnable {}

// MARK: - Properties
public extension MGWrapper_Mg where MGOriginType == MGFloat {
    /// String value from Float (if applicable).
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
    var ceil: MGFloat {
        return ceilf(origin)
    }
    
    /// Take an integer no greater than this number
    ///
    ///   88.88.floor -> 88
    ///
    var floor: MGFloat {
        return floorf(origin)
    }
    
    /// Round to the nearest whole number
    ///
    ///   88.88.round -> 89
    ///   88.45.round -> 88
    ///
    var round: MGFloat {
        return roundf(origin)
    }
    
}
