//
//  MG+View+Property.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/31.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

// MARK: - property
public extension MGWrapper_Mg where MGOriginType: MGView {
    /// Return the picture of the view
    var capture: MGImage? {
        UIGraphicsBeginImageContext(origin.bounds.size)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        origin.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        return image
    }
    
}
