//
//  MG+String+Extension.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/5.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

extension MGString: MGWrapperEnable {}

// MARK: - Properties
public extension MGWrapper_Mg where MGOriginType == MGString {
    /// String length
    var length: MGInt {
        return origin.count
    }
    
    /// Judgment string is not empty
    var isNotEmpty: MGBool {
        return !origin.isEmpty
    }
    
    /// Capitalize the first letter of a sentence
    /// 
    /// Returns: A new sentence with the first letter capitalized
    var uppercasedAtSentenceBoundary: MGString {
        let string = origin.lowercased()
        
        let capacity = string.count
        let mutable = NSMutableString(capacity: capacity)
        mutable.append(string)
        
        let pattern = "(?:^|\\b\\.[ ]*)(\\p{Ll})"
        
        if let regex = try? NSRegularExpression(pattern: pattern, options: .anchorsMatchLines) {
            let results = regex.matches(in: string, options: [], range: NSMakeRange(0, capacity))
            for result in results {
                let numRanges = result.numberOfRanges
                if numRanges >= 1 {
                    for i in 1..<numRanges {
                        let range = result.range(at: i)
                        let substring = mutable.substring(with: range)
                        mutable.replaceCharacters(in: range, with: substring.uppercased())
                    }
                }
            }
        }
        
        return mutable as MGString
    }
    
    // MARK: - base64 Codec
    /// String encoded in base64 (if applicable).
    var base64Encoded: MGString? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = origin.data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    /// String decoded from base64 (if applicable).
    var base64Decoded: MGString? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        guard let decodedData = Data(base64Encoded: origin) else { return nil }
        return MGString(data: decodedData, encoding: .utf8)
    }
    
    /// encode string to unicode
    var unicodeEncoded: MGString {
        var result = ""
        for scalar in origin.unicodeScalars {
            result += "\\u\(String(scalar.value, radix: 16))"
        }
        
        return result
    }
    
    /// decode unicode to plain string
    var unicodeDecoded: MGString? {
        let tempString = origin.replacingOccurrences(of: "\\u", with: "\\U")
            .replacingOccurrences(of:"\"", with: "\\\"")
        
        if let tempData = "\"\(tempString)\"".data(using: .utf8) {
            if let res = try? PropertyListSerialization.propertyList(from: tempData, options: [], format: nil) {
                return res as? MGString
            }
        }
        return nil
    }
    
    // MARK: - URL Codec
    ///
    /// Url String encoded in String (if applicable).
    ///
    ///     "https://www.哈喽.com?a=1&b=2" -> "https://www.%E5%93%88%E5%96%BD.com?a=1&b=2"
    ///
    var urlEncodedString: MGString {
        if #available(iOS 9.0, macOS 10.12, *) {
            if let esc = origin.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                return esc
            }
            return origin
        } else {
            let chars = ":&=;+!@#$()',*"
            let legalURLCharactersToBeEscaped: CFString = chars as CFString
            return CFURLCreateStringByAddingPercentEscapes(nil, origin as CFString?, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
        }
    }
    
    /// Url String decoded from String (if applicable).
    ///
    ///     "https://www.%E5%93%88%E5%96%BD.com?a=1&b=2" -> "https://www.哈喽.com?a=1&b=2"
    ///
    var urlDecodedString: MGString {
        if #available(iOS 9.0, macOS 10.12, *) {
            if let esc = origin.removingPercentEncoding {
                return esc
            }
            return origin
        } else {
            return CFURLCreateStringByReplacingPercentEscapesUsingEncoding(nil, origin as CFString?, "" as CFString?, CFStringBuiltInEncodings.UTF8.rawValue) as MGString
        }
    }
    
    /// URL escaped string.
    ///
    ///    "https://www.哈喽.com?a=1&b=2" -> "https%3A%2F%2Fwww.%E5%93%88%E5%96%BD.com%3Fa=1&b=2"
    ///
    var urlEncoded: MGString {
        return origin.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    /// Readable string from a URL string.
    ///
    ///    "https%3A%2F%2Fwww.%E5%93%88%E5%96%BD.com%3Fa=1&b=2" -> "https://www.哈喽.com?a=1&b=2"
    ///
    var urlDecoded: MGString {
        return origin.removingPercentEncoding ?? origin
    }
    
    /// Array of characters of a string.
    var charactersArray: [Character] {
        return Array(origin)
    }
    
    /// CamelCase of string.
    /// - "sOme vAriable naMe".camelCased -> "someVariableName"
    var camelCased: MGString {
        let source = origin.lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            return first + rest
        }
        let rest = MGString(source.dropFirst())
        return first + rest
    }
    
    /// Check if string contains one or more emojis.
    /// - "Hello 😀".containEmoji -> true
    var containEmoji: MGBool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in origin.unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
            0x1D000...0x1F77F, // Emoticons
            0x2100...0x27BF, // Misc symbols and Dingbats
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    
    /// First character of string (if applicable).
    ///
    ///    "Hello".firstCharacterAsString -> Optional("H")
    ///    "".firstCharacterAsString -> nil
    ///
    var firstCharacterAsString: MGString? {
        guard let first = origin.first else { return nil }
        return MGString(first)
    }
    
    /// Last character of string (if applicable).
    ///
    ///    "Hello".lastCharacterAsString -> Optional("o")
    ///    "".lastCharacterAsString -> nil
    ///
    var lastCharacterAsString: MGString? {
        guard let last = origin.last else { return nil }
        return MGString(last)
    }
    
    /// Check if string contains one or more letters.
    ///
    ///    "123abc".hasLetters -> true
    ///    "123".hasLetters -> false
    ///
    var hasLetters: MGBool {
        return origin.rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// Check if string contains one or more numbers.
    ///
    ///    "abcd".hasNumbers -> false
    ///    "123abc".hasNumbers -> true
    ///
    var hasNumbers: MGBool {
        return origin.rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    /// Check if string contains only letters.
    ///
    ///    "abc".isAlphabetic -> true
    ///    "123abc".isAlphabetic -> false
    ///
    var isAlphabetic: MGBool {
        let hasLetters = origin.rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = origin.rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return hasLetters && !hasNumbers
    }
    
    /// Check if string contains at least one letter and one number.
    ///
    ///    // useful for passwords
    ///    "123abc".isAlphaNumeric -> true
    ///    "abc".isAlphaNumeric -> false
    ///    "123".isAlphaNumeric -> false
    ///
    var isAlphaNumeric: MGBool {
        let hasLetters = origin.rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = origin.rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = origin.components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    
    /// Check if string is valid email format.
    ///
    ///    "john@doe.com".isEmail -> true
    ///
    var isEmail: MGBool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    }
    
    /// Check if string is a valid URL.
    ///
    ///    "https://google.com".isValidUrl -> true
    ///
    var isValidUrl: MGBool {
        return URL(string: origin) != nil
    }
    
    /// Check if string is a valid schemed URL.
    ///
    ///    "https://google.com".isValidSchemedUrl -> true
    ///    "google.com".isValidSchemedUrl -> false
    ///
    var isValidSchemedUrl: MGBool {
        guard let url = URL(string: origin) else { return false }
        return url.scheme != nil
    }
    
    /// Check if string is a valid https URL.
    ///
    ///    "https://google.com".isValidHttpsUrl -> true
    ///
    var isValidHttpsUrl: MGBool {
        guard let url = URL(string: origin) else { return false }
        return url.scheme == "https"
    }
    
    /// Check if string is a valid http URL.
    ///
    ///    "http://google.com".isValidHttpUrl -> true
    ///
    var isValidHttpUrl: MGBool {
        guard let url = URL(string: origin) else { return false }
        return url.scheme == "http"
    }
    
    /// Check if string is a valid file URL.
    ///
    ///    "file://Documents/file.txt".isValidFileUrl -> true
    ///
    var isValidFileUrl: MGBool {
        return URL(string: origin)?.isFileURL ?? false
    }
    
    /// Check if string contains only numbers.
    ///
    ///    "123".isNumeric -> true
    ///    "abc".isNumeric -> false
    ///
    var isNumeric: MGBool {
        let hasLetters = origin.rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = origin.rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return !hasLetters && hasNumbers
    }
    
    /// Latinized string.
    ///
    ///    "Hèllö Wórld!".latinized -> "Hello World!"
    ///
    var latinized: MGString {
        return origin.folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    /// Date object from "yyyy-MM-dd" formatted string.
    ///
    ///    "2007-06-29".date -> Optional(Date)
    ///
    var date: MGDate? {
        let selfLowercased = trim.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    /// Date object from "yyyy-MM-dd HH:mm:ss" formatted string.
    ///
    ///    "2007-06-29 14:23:09".dateTime -> Optional(Date)
    ///
    var dateTime: MGDate? {
        let selfLowercased = trim.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    
    /// Bool value from string (if applicable).
    ///
    ///    "1".bool -> true
    ///    "False".bool -> false
    ///    "Hello".bool = nil
    ///
    var bool: MGBool? {
        let selfLowercased = trim.lowercased()
        if selfLowercased == "true" || selfLowercased == "1" {
            return true
        } else if selfLowercased == "false" || selfLowercased == "0" {
            return false
        }
        return nil
    }
    
    /// Integer value from string (if applicable).
    ///
    ///    "88".int -> 88
    ///    "Hello".int = nil
    ///
    var int: MGInt? {
        return MGInt(origin)
    }
    
    /// Float value from string (if applicable).
    ///
    ///    "88.88".Float -> 88.88
    ///    "Hello".Float = nil
    ///
    var float: MGFloat? {
        return MGFloat(origin)
    }
    
    /// Double value from string (if applicable).
    ///
    ///    "88.88".Double -> 88.88
    ///    "Hello".Double = nil
    ///
    var double: MGDouble? {
        return MGDouble(origin)
    }
    
    /// URL from string (if applicable).
    ///
    ///    "https://hello.com".url -> URL(string: "https://hello.com")
    ///    "not url".url -> nil
    ///
    var url: MGURL? {
        return URL(string: origin)
    }
    
    /// String with no spaces or new lines in beginning and end.
    ///
    ///    "   hello  \n" -> "hello"
    ///
    var trim: MGString {
        return origin.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// String without spaces and new lines.
    ///
    ///   "   \n Swifter   \n  Swift  " -> "SwifterSwift"
    ///
    var withoutSpacesAndNewLines: MGString {
        return origin.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
    
    /// Check if the given string contains only white spaces
    var isWhitespace: MGBool {
        return origin.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// Count the number of lowercase characters.
    ///
    /// - Returns: Number of lowercase characters.
    var countLowercasedCharacters: MGInt {
        var countChar = 0
        for i in 0 ..< self.length {
            guard let character = UnicodeScalar((NSString(string: origin)).character(at: i)) else {
                return 0
            }
            let isLowercase = CharacterSet.lowercaseLetters.contains(character)
            if isLowercase {
                countChar += 1
            }
        }
        
        return countChar
    }
    
    /// Count the number of uppercase characters.
    ///
    /// - Returns: Number of uppercase characters.
    var countUppercasedCharacters: MGInt {
        var countChar = 0
        for i in 0 ..< self.length {
            guard let character = UnicodeScalar((NSString(string: origin)).character(at: i)) else {
                return 0
            }
            let isUppercase = CharacterSet.uppercaseLetters.contains(character)
            if isUppercase {
                countChar += 1
            }
        }
        
        return countChar
    }
    
    /// Count the number of numbers.
    ///
    /// - Returns: Number of numbers.
    var countNumbers: MGInt {
        var countNumber = 0
        for i in 0 ..< self.length {
            guard let character = UnicodeScalar((NSString(string: origin)).character(at: i)) else {
                return 0
            }
            let isNumber = CharacterSet(charactersIn: "0123456789").contains(character)
            if isNumber {
                countNumber += 1
            }
        }
        
        return countNumber
    }
    
    /// Count the number of symbols.
    ///
    /// - Returns: Number of symbols.
    var countSymbols: MGInt {
        var countSymbol = 0
        for i in 0 ..< self.length {
            guard let character = UnicodeScalar((NSString(string: origin)).character(at: i)) else {
                return 0
            }
            let isSymbol = CharacterSet(charactersIn: "`~!?@#$€£¥§%^&*()_+-={}[]:\";.,<>'•\\|/").contains(character)
            if isSymbol {
                countSymbol += 1
            }
        }
        
        return countSymbol
    }
    
    /// Convert HEX string (separated by space) to "usual" characters string.
    /// Example: "68 65 6c 6c 6f" -> "hello".
    ///
    /// - Returns: Readable string.
    var stringFromHEX: MGString {
        var hex = origin
        hex = hex.replacingOccurrences(of: " ", with: "")
        var string: MGString = ""
        while !hex.isEmpty {
            let character = MGString(hex[..<hex.index(hex.startIndex, offsetBy: 2)])
            hex = MGString(hex[hex.index(hex.startIndex, offsetBy: 2)...])
            var characterInt: UInt32 = 0
            _ = Scanner(string: character).scanHexInt32(&characterInt)
            string += MGString(format: "%c", characterInt)
        }
        return string
    }
}

// MARK: - Substring
public extension MGWrapper_Mg where MGOriginType == MGString {
    /// Returns a substring
    ///
    /// - Parameters:
    ///   - from: The index of the starting position of the string(containing the characters at this position)
    func substring(from index: MGInt) -> MGString {
        if index <= 0 { return "" }
        if index >= origin.count { return "" }
        return (origin as NSString).substring(from: index)
    }
    
    /// Returns a substring
    ///
    /// - Parameters:
    ///   - to: The index of the end position of the string(does not contain the characters at this position)
    func substring(to index: MGInt) -> MGString {
        if index <= 0 { return "" }
        if index >= origin.count { return origin }
        return (origin as NSString).substring(to: index)
    }
    
    /// Returns a substring
    ///
    /// - Parameters:
    ///   - with: The range of the substring into the string(contain the character of the min position, but does not contain the characters at the max position, such as 1...3)
    func substring(with range: CountableClosedRange<Int>) -> MGString {
        let min = (range.lowerBound < 0) ? 0 : range.lowerBound
        let max = (range.upperBound >= origin.count) ? origin.count : range.upperBound
        return (origin as NSString).substring(with: NSRange(location: min, length: max - min))
    }
}

public extension MGWrapper_Mg where MGOriginType == MGString {
    /// Remove double or more duplicated spaces.
    ///
    /// - returns: The string that have removed double or more duplicated spaces.
    func removeExtraSpaces() -> MGString {
        let squashed = origin.replacingOccurrences(of: "[ ]+", with: " ", options: .regularExpression, range: nil)
        return squashed.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// Returns a new string in which all occurrences of a target strings in a specified range of the String are replaced by another given string.
    ///
    /// - Parameters:
    ///   - target: Target strings array.
    ///   - replacement: Replacement string.
    /// - Returns: Returns a new string in which all occurrences of a target strings in a specified range of the String are replaced by another given string.
    func replacingOccurrences(of target: [MGString], with replacement: MGString) -> MGString {
        var string = origin
        for occurrence in target {
            string = string.replacingOccurrences(of: occurrence, with: replacement)
        }
        
        return string
    }
    
    /// Verify if string matches the regex pattern.
    ///
    /// - Parameter pattern: Pattern to verify.
    /// - Returns: true if string matches the pattern.
    func matches(pattern: MGString) -> MGBool {
        return origin.range(of: pattern,
                            options: MGString.CompareOptions.regularExpression,
                            range: nil, locale: nil) != nil
    }
    
    /// Returns a string by padding to fit the length parameter size with another string in the start.
    ///
    ///   "hue".paddingStart(10) -> "       hue"
    ///   "hue".paddingStart(10, with: "br") -> "brbrbrbhue"
    ///
    /// - Parameter length: The target length to pad.
    /// - Parameter string: Pad string. Default is " ".
    /// - Returns: The string with the padding on the start.
    func paddingStart(_ length: MGInt, with string: MGString = " ") -> MGString {
        let count = self.length
        guard count < length else { return origin }
        
        let padLength = length - count
        if padLength < string.count {
            return string[string.startIndex..<string.index(string.startIndex, offsetBy: padLength)] + origin
        } else {
            var padding = string
            while padding.count < padLength {
                padding.append(string)
            }
            return padding[padding.startIndex..<padding.index(padding.startIndex, offsetBy: padLength)] + origin
        }
    }
    
    /// Returns a string by padding to fit the length parameter size with another string in the end.
    ///
    ///   "hue".paddingEnd(10) -> "hue       "
    ///   "hue".paddingEnd(10, with: "br") -> "huebrbrbrb"
    ///
    /// - Parameter length: The target length to pad.
    /// - Parameter string: Pad string. Default is " ".
    /// - Returns: The string with the padding on the end.
    func paddingEnd(_ length: MGInt, with string: MGString = " ") -> MGString {
        let count = self.length
        guard count < length else { return origin }
        
        let padLength = length - count
        if padLength < string.count {
            return origin + string[string.startIndex..<string.index(string.startIndex, offsetBy: padLength)]
        } else {
            var padding = string
            while padding.count < padLength {
                padding.append(string)
            }
            return origin + padding[padding.startIndex..<padding.index(padding.startIndex, offsetBy: padLength)]
        }
    }
    
}
