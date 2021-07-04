//
//  MGUserDefaults.swift
//  MGSwiftCandy
//
//  Created by msz on 2021/6/29.
//

import Foundation

public struct MGUserDefaults: MGWrapperEnable { }

public extension MGWrapper_Mg where MGOriginType == MGUserDefaults {

    /// Set the information
    ///
    /// - Parameters:
    ///   - key: Key to store content
    ///   - value: The value to be stored
    static func set<Type: Codable>(key: MGString, value: Type) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(value) else {
            return
        }
        
        let userDefault = UserDefaults.standard
        userDefault.setValue(data, forKey: key)
        userDefault.synchronize()
    }
    
    /// Get the information
    ///
    /// - Parameters:
    ///   - key Key used to query information
    /// - Returns
    ///   - Query result
    static func get<Type: Codable>(key: MGString) -> Type? {
        let userDefault = UserDefaults.standard
        guard let data = userDefault.value(forKey: key) as? Data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        let retObj = try? decoder.decode(Type.self, from: data)
        return retObj
    }
    
    /// Removed the value with key
    ///
    /// - Parameters:
    ///   - key: To remove the value used this key
    static func remove(key: MGString) {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: key)
    }
    
}
