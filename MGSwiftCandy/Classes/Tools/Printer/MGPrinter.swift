//
//  MGPrinter.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/23.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

public class MGPrinter: MGWrapperEnable {}

public extension MGWrapper_Mg where MGOriginType: MGPrinter {
    /// Print log info into the output window
    /// - Parameters
    ///   - items: log info
    ///   - type: log type
    ///   - tag: log tag
    ///   - separator: separator
    ///   - terminator: terminator
    ///   - function: Functions that trigger logs
    ///   - file: File that trigger logs
    ///   - line: Line that trigger logs
    static func printer(_ items: Any?...,
                        type: MGPrinterType = .debug,
                        tag: String? = nil,
                        separator: String = " ",
                        terminator: String = "",
                        function: String = #function,
                        line: Int = #line,
                        file: String = #file) {
        CustomPrint(items,
                    type: type,
                    tag: tag,
                    separator: separator,
                    terminator: terminator,
                    function: function,
                    line: line,
                    file: file,
                    target: nil)
    }
    
    /// Print log info into target
    /// - Parameters
    ///   - items: log info
    ///   - type: log type
    ///   - tag: log tag
    ///   - separator: separator
    ///   - terminator: terminator
    ///   - function: Functions that trigger logs
    ///   - file: File that trigger logs
    ///   - line: Line that trigger logs
    static func printer(_ items: Any?...,
                        type: MGPrinterType = .debug,
                        tag: String? = nil,
                        separator: String = " ",
                        terminator: String = "",
                        function: String = #function,
                        line: Int = #line,
                        file: String = #file,
                        target: inout String) {
        let retString = MGOutStream()
        CustomPrint(items,
                    type: type,
                    tag: tag,
                    separator: separator,
                    terminator: terminator,
                    function: function,
                    line: line,
                    file: file,
                    target: retString)
        
        target = retString.string
    }

    private static func CustomPrint(_ items: [Any?],
                                    type: MGPrinterType,
                                    tag: String?,
                                    separator: String,
                                    terminator: String,
                                    function: String,
                                    line: Int,
                                    file: String,
                                    target: MGOutStream?) {
        #if DEBUG
        let msgs = items.map({ (i) -> String in
            if let s = i as? String { return s }
            if let i = i { return MGTools.mg.dumper(i) }
            return "nil"
        })
        
        let sep = "----------------------- \(tag ?? "")"
        let results: [String] = [
            sep,
            "▷ [\(type.symbol)] \(tag ?? type.tag)",
            "▷ [📃] \(String(describing: URL(fileURLWithPath: file).lastPathComponent)) [\(line)]",
            "▷ [✂️] \(function)",
            "▷ [⏰] " + dateFormat(date: Date()),
            "\(msgs.joined(separator: separator))",
            sep
        ]
        
        if var target = target {
            print(results.joined(separator: "\n"), "\n", separator: separator, terminator: terminator, to: &target)
        } else {
            print(results.joined(separator: "\n"), "\n", separator: separator, terminator: terminator)
        }
        #endif
    }

    
    private static func dateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}

public extension MGWrapper_Mg where MGOriginType: MGPrinter {
    class MGOutStream: TextOutputStream {
        public var string: String = ""
        public func write(_ string: String) {
            self.string = "\(self.string)\(string)"
        }
    }
    
    enum MGPrinterType: Equatable {
        case debug
        case error
        case info
        case warning
        case dumping
        case custom(String)
        
        fileprivate var symbol: String {
            switch self {
            case .debug:   return "💬"
            case .error:   return "❌"
            case .info:    return "ℹ️"
            case .warning: return "⚠️"
            case .dumping: return "🆔"
            case .custom(let s):
                return s
            }
        }
        
        fileprivate var tag: String {
            switch self {
            case .debug:
                return "DEBUG"
            case .error:
                return "ERROR"
            case .info:
                return "INFO"
            case .warning:
                return "WARINIG"
            case .dumping:
                return "DUMPING"
            case .custom:
                return "CUSTOM"
            }
        }
        
        public static func ==(lhs: MGPrinterType, rhs: MGPrinterType) -> Bool {
            switch (lhs, rhs) {
            case (.debug, .debug),
                 (.error, .error),
                 (.info, .info),
                 (.warning, .warning),
                 (.dumping, .dumping):
                return true
            case let (.custom(a), .custom(b)):
                return a == b
            default:
                return false
            }
        }
    }
}
