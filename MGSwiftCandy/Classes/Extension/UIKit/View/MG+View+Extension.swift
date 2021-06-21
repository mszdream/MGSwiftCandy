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
    var x: CGFloat {
        get { return origin.frame.origin.x }
        set { origin.frame.origin.x = newValue }
    }
    
    var y: CGFloat {
        get { return origin.frame.origin.y }
        set { origin.frame.origin.y = newValue }
    }
    
    var width: CGFloat {
        get { return origin.frame.size.width }
        set { origin.frame.size.width = newValue }
    }
    
    var height: CGFloat {
        get { return origin.frame.size.height }
        set { origin.frame.size.height = newValue }
    }
    
    var centerX: CGFloat {
        get { return origin.center.x }
        set { origin.center.x = newValue }
    }
    
    var centerY: CGFloat {
        get { return origin.center.y }
        set { origin.center.y = newValue }
    }
    
    var origin: CGPoint {
        get { return origin.frame.origin }
        set { origin.frame.origin = newValue }
    }
    
    var size: CGSize {
        get { return origin.frame.size }
        set { origin.frame.size = newValue }
    }
    
}
