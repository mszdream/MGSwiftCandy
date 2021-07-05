//
//  MGKeychain.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/6/27.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

public struct MGKeychain: MGWrapperEnable { }

public extension MGWrapper_Mg where MGOriginType == MGKeychain {
    private typealias MGQueryType = [String: Any]
    
    static let kInvalidParameters: OSStatus = 1001
    static let defaultService: String = {
        return Bundle.main.bundleIdentifier ?? ""
    }()
}

// MARK: - Object
public extension MGWrapper_Mg where MGOriginType == MGKeychain {
    /// Write content to Keychain
    ///
    /// - Parameters:
    ///   - services: Services where content is stored
    ///   - account: Account where content is stored
    ///   - password: The content of the Object type(conform NSCoding protocol) that needs to be stored
    ///   - accessGroup: Access group
    /// - Returns:
    ///   - Operation status
    @discardableResult
    static func setPassword<Type: Codable>(service: String = defaultService,
                            account: MGString,
                            password: Type,
                            accessGroup: MGString = "") -> OSStatus {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(password) else {
            return kInvalidParameters
        }
        
        let query = self.query(service: service, account: account, accessGroup: accessGroup)
        let status = self.save(query: query, password: data)
        return status
    }
    
    /// Search content from keychain
    ///
    /// - Parameters:
    ///   - service: Services where content is stored
    ///   - account: Account where content is stored
    ///   - accessGroup: Access group
    /// - Returns:
    ///   - The content of the Object type(conform NSCoding protocol) searched out
    @discardableResult
    static func getPassword<Type: Codable>(service: MGString = defaultService,
                            account: MGString,
                            accessGroup: MGString = "") -> Type? {
        let query = self.query(service: service, account: account, accessGroup: accessGroup)
        var data = Data()
        self.fetch(query: query, password: &data)
        let decoder = JSONDecoder()
        let password = try? decoder.decode(Type.self, from: data)
        return password
    }
    
    /// Remove content of keychain
    ///
    /// - Parameters:
    ///   - service: Services where content is stored
    ///   - account: Account where content is stored
    ///   - accessGroup: Access group
    /// - Returns:
    ///   - Operations status
    @discardableResult
    static func remove(service: MGString = defaultService,
                       account: MGString,
                       accessGroup: MGString = "") -> OSStatus {
        let query = self.query(service: service, account: account, accessGroup: accessGroup)
        let status = self.delete(query: query)
        return status
    }
    
    /// Search all contents from keychain
    ///
    /// - Parameters:
    ///   - service: Services where contents are stored
    ///   - accessGroup: Access group
    /// - Returns:
    ///   - The contents of the Object type(conform NSCoding protocol) searched out
    @discardableResult
    static func allPasswords<Type: Codable>(service: MGString? = nil, accessGroup: MGString? = nil) -> [Type] {
        let query = self.query(service: service ?? "", account: "", accessGroup: "")
        var datas: [Data] = []
        fetchAll(query: query, password: &datas)
        
        let decoder = JSONDecoder()
        var result: [Type] = []
        for data in datas {
            if let password = try? decoder.decode(Type.self, from: data) {
                result.append(password)
            }
        }
        
        return result
    }
}

// MARK: - Private method
public extension MGWrapper_Mg where MGOriginType == MGKeychain {
    /// Save content into keychain(insert or update)
    ///
    /// - Parameters:
    ///   - query: Structure conditions to store
    ///   - password: Content to store
    /// - Returns:
    ///   - Operation status
    @discardableResult
    private static func save(query: MGQueryType, password: MGData) -> OSStatus {
        var status = SecItemCopyMatching(query as CFDictionary, nil)
        var attributes = MGQueryType()

        switch status {
        case errSecSuccess:
            attributes[kSecValueData as String] = password
            status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        case errSecItemNotFound:
            var query = query
            query[kSecValueData as String] = password
            status = SecItemAdd(query as CFDictionary, nil)
        default:
            break
        }
        
        return status
    }
    
    /// Search content from keychain
    ///
    /// - Parameters:
    ///   - query: Search corditions
    ///   - password: Search out content
    /// - Returns:
    ///   - Operation status
    @discardableResult
    private static func fetch(query: MGQueryType, password: inout MGData) -> OSStatus {
        var query = query
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        if let result = result as? Data {
            password = result
        }
        
        return status
    }
    
    /// Search all contents from keychain
    ///
    /// - Parameters:
    ///   - query: Search corditions
    ///   - password: Search out all contents
    /// - Returns:
    ///   - Operation status
    @discardableResult
    private static func fetchAll(query: MGQueryType, password: inout [MGData]) -> OSStatus {
        var query = query
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitAll
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        if let result = result as? [Data] {
            password = result
        }
        
        return status
    }
    
    /// Remove content of keychain
    ///
    /// - Parameters:
    ///   - query: Remove content from keychain according to the information in query
    /// - Returns:
    ///   - Operation status
    @discardableResult
    private static func delete(query: MGQueryType) -> OSStatus {
        let status = SecItemDelete(query as CFDictionary)
        return status
    }
    
    /// Building query criteria
    ///
    /// - Parameters:
    ///   - services: Services where content is stored
    ///   - account: Account where content is stored
    ///   - accessGroup: Access group
    /// - Returns:
    ///   - A instance of type MGQueryType
    @discardableResult
    private static func query(service: MGString = defaultService,
                              account: MGString,
                              accessGroup: MGString = "") -> MGQueryType {
        var query: MGQueryType = [kSecClass as MGString: kSecClassGenericPassword]
        query[kSecAttrAccessible as String] = kSecAttrAccessibleAlways
        if !service.isEmpty {
            query[kSecAttrService as String] = service
        }
        if !account.isEmpty {
            query[kSecAttrAccount as String] = account
        }
        #if targetEnvironment(simulator)
        // Ignore the access group if running on the iPhone simulator.
        //
        // Apps that are built for the simulator aren't signed, so there's no keychain access group
        // for the simulator to check. This means that all apps can see all keychain items when run
        // on the simulator.
        //
        // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
        // simulator will return -25243 (errSecNoAccessForItem).
        #else
        if !accessGroup.isEmpty {
            query[kSecAttrAccessGroup as MGString] = accessGroup
        }
        #endif
        
        return query
    }
    
}
