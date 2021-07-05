//
//  MG+Bool+Extension.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/7/4.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

extension MGBool: MGWrapperEnable {}

// MARK: - Properties
public extension MGWrapper_Mg where MGOriginType == MGBool {
    /// String value from Double (if applicable).
    ///
    ///    true.stringify -> "true"
    ///
    var stringify: MGString {
        return MGString(origin)
    }
    
}
