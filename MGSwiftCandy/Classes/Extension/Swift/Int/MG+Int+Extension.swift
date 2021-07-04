//
//  MG+Int+Extension.swift
//  MGSwiftCandy
//
//  Created by msz on 2021/7/4.
//

extension MGInt: MGWrapperEnable {}

// MARK: - Properties
public extension MGWrapper_Mg where MGOriginType == MGInt {
    /// String value from Int (if applicable).
    ///
    ///    88.stringify -> "88"
    ///
    var stringify: MGString {
        return MGString(origin)
    }
    
}
