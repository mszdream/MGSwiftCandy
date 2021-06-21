//
//  MGWrapper.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/1.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

protocol MGWrapper {
    associatedtype MGOriginType: MGWrapperEnable
    
    var origin: MGOriginType { get }
}

public struct MGWrapper_Mg<MGOriginType: MGWrapperEnable>: MGWrapper {
    typealias MGOriginType = MGOriginType
    
    internal var origin: MGOriginType
    
    init(origin: MGOriginType) {
        self.origin = origin
    }
}

public protocol MGWrapperEnable {}
public extension MGWrapperEnable {
    var mg: MGWrapper_Mg<Self> {
        get { return MGWrapper_Mg.init(origin:self) }
        set {}
    }
    
    static var mg: MGWrapper_Mg<Self>.Type {
        return MGWrapper_Mg<Self>.self
    }
}


/// One_GenericElement
protocol MGWrapper_One_GenericElement {
    associatedtype MGOriginType: MGWrapperEnable_One_GenericElement
    
    var origin: MGOriginType { get }
}

public struct MGWrapper_One_Mg<MGOriginType: MGWrapperEnable_One_GenericElement, Element>: MGWrapper_One_GenericElement {
    typealias MGOriginType = MGOriginType
    
    internal var origin: MGOriginType
    
    init(origin: inout MGOriginType) {
        self.origin = origin
    }
}

public protocol MGWrapperEnable_One_GenericElement {
    associatedtype Element
}
public extension MGWrapperEnable_One_GenericElement {
    var mg: MGWrapper_One_Mg<Self, Element> {
        mutating get { return MGWrapper_One_Mg.init(origin:&self) }
        set {}
    }
    
    static var mg: MGWrapper_One_Mg<Self, Element>.Type {
        return MGWrapper_One_Mg<Self, Element>.self
    }
}
