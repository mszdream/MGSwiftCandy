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
    static var width: MGCGFloat {
        return MGScreen.main.bounds.size.width
    }
    
    static var height: MGCGFloat {
        return MGScreen.main.bounds.size.height
    }
    
    static var scale: MGCGFloat {
        return MGScreen.main.scale
    }
    
}
