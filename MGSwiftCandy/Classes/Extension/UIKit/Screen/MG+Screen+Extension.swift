//
//  MG+Screen+Extension.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/6.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

extension MGScreen: MGWrapperEnable {}

public extension MGWrapper_Mg where MGOriginType == MGScreen {
    static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    static var scale: CGFloat {
        return UIScreen.main.scale
    }
    
}
