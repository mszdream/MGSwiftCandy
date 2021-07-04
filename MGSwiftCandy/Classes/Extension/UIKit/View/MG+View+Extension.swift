//
//  MG+View+Extension.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/5.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

extension MGView: MGWrapperEnable {}

// MARK: - property
public extension MGWrapper_Mg where MGOriginType: MGView {
    var x: MGCGFloat {
        get { return origin.frame.origin.x }
        set { origin.frame.origin.x = newValue }
    }
    
    var y: MGCGFloat {
        get { return origin.frame.origin.y }
        set { origin.frame.origin.y = newValue }
    }
    
    var width: MGCGFloat {
        get { return origin.frame.size.width }
        set { origin.frame.size.width = newValue }
    }
    
    var height: MGCGFloat {
        get { return origin.frame.size.height }
        set { origin.frame.size.height = newValue }
    }
    
    var centerX: MGCGFloat {
        get { return origin.center.x }
        set { origin.center.x = newValue }
    }
    
    var centerY: MGCGFloat {
        get { return origin.center.y }
        set { origin.center.y = newValue }
    }
    
    var origin: MGCGPoint {
        get { return origin.frame.origin }
        set { origin.frame.origin = newValue }
    }
    
    var size: MGCGSize {
        get { return origin.frame.size }
        set { origin.frame.size = newValue }
    }
    
}
