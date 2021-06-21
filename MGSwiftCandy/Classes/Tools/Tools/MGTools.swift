//
//  MGTools.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/23.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

public class MGTools: MGWrapperEnable {}

public extension MGWrapper_Mg where MGOriginType: MGTools {
    /// Get the name of the namespace dynamically
    static func getNameSpaceName() -> String? {
        guard let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("get namespace failed!")
            return nil
        }
        
        return spaceName
    }
    
    /// Create class type by name
    /// 
    /// - Parameters:
    ///   - className: class name
    ///   - nameSpaceName: namespace name
    /// - Returns:
    ///   - Return a class type
    static func createClass<T: MGCreate>(className: String, nameSpaceName: String? = nil) -> T.Type? {
        var nameSpace: String?
        if let nameSpaceName = nameSpaceName, nameSpaceName.count > 0 {
            nameSpace = nameSpaceName
        } else {
            nameSpace = self.getNameSpaceName()
        }
        
        guard let nameSpace = nameSpace, className.count > 0,
              let klass: AnyClass = NSClassFromString(nameSpace + "." + className),
              let typeClass = klass as? T.Type else {
            return nil
        }
        
        return typeClass
    }
    
    /// Create instance by class name
    ///
    /// - Parameters:
    ///   - className: class name
    ///   - nameSpaceName: namespace name
    /// - Returns:
    ///   - Return a instance
    static func create<T: MGCreate>(className: String, nameSpaceName: String? = nil) -> T? {
        guard let typeClass: T.Type = createClass(className: className, nameSpaceName: nameSpaceName) else {
            return nil
        }
        
        let instance = typeClass.init()
        return instance
    }
    
}

public extension MGWrapper_Mg where MGOriginType: MGTools {
    static func dumper(_ item: Any?) -> String {
        var output = ""
        guard let i = item else {
            return output
        }
        
        dump(i, to: &output)
        return output
    }
}


