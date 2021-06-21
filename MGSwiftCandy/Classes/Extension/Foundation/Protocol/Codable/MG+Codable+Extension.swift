//
//  MG+Codable+Extension.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/24.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

/// Note: The data types in the model must be consistent with those in JSON

// MARK: - MGDecodable
public extension MGDecodable {
    /// Instance from JSON string
    /// - Parameters:
    ///   - jsonString: JSON string
    ///   - stringEncoding: Encoding
    /// - Returns: A model instance, return `nil` if failed
    static func decode(from jsonString: String, encoding: String.Encoding = .utf8) -> Self? {
        guard let jsonData = jsonString.data(using: encoding) else {
            return nil
        }
        guard let jsonObject = (try? JSONSerialization.jsonObject(with: jsonData, options: [])) as? [String: Any] else {
            return nil
        }
        return self.decode(from: jsonObject)
    }
    
    /// Instance from JSON object
    /// - Parameters:
    ///   - jsonObject: JSON object
    /// - Returns: A model instance, return `nil` if failed
    static func decode(from jsonObject: [String: Any]) -> Self? {
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            return try JSONDecoder().decode(self, from: data)
        } catch let error {
            print(error)
            return nil
        }
    }
    
    /// Instance from JSON object
    /// - Parameters:
    ///   - data: JSON data
    /// - Returns: A model instance, return `nil` if failed
    static func decode(from data: Data) -> Self? {
        do {
            return try JSONDecoder().decode(self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}

// MARK: - MGEncodable
public extension MGEncodable {
    /// To JSON Data
    var encoded: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            print(error)
            return nil
        }
    }
    
    /// To JSON string
    var jsonify: String? {
        if let data = (self as? Data) {
            if let str = String.init(data: data, encoding: .utf8) {
                return str
            }
        }
        
        guard let encodedData = self.encoded else {
            return nil
        }
        return String.init(data: encodedData, encoding: .utf8)
    }
}
