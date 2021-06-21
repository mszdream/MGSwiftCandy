//
//  MG+Color+Extension.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/5.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

extension MGColor: MGWrapperEnable {}

// MARK: - Properties
public extension MGWrapper_Mg where MGOriginType == MGColor {
    /// Random color.
    static var random: MGColor {
        let r = CGFloat(arc4random_uniform(255)) / CGFloat(255)
        let g = CGFloat(arc4random_uniform(255)) / CGFloat(255)
        let b = CGFloat(arc4random_uniform(255)) / CGFloat(255)
        return MGColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    /// RGB components for a Color (between 0 and 255).
    /// - Returns:
    ///   - red: MGColor.red.rgbComponents
    ///   - green: MGColor.green.rgbComponents
    ///   - blue: MGColor.blue.rgbComponents
    var rgbComponents: (red: Int, green: Int, blue: Int) {
        let tuple = rgbaComponents
        return (red: tuple.red, green: tuple.green, blue: tuple.blue)
    }
    
    /// RGB components for a Color (between 0 and 255).
    /// - Returns:
    ///   - red: MGColor.red.rgbComponents
    ///   - green: MGColor.green.rgbComponents
    ///   - blue: MGColor.blue.rgbComponents
    ///   - alpha: MGColor.alpha
    var rgbaComponents: (red: Int, green: Int, blue: Int, alpha: Int) {
        let tuple = rgbaFloatComponents
        return (red: Int(tuple.red * 255.0),
                green: Int(tuple.green * 255.0),
                blue: Int(tuple.blue * 255.0),
                alpha: Int(tuple.alpha * 255))
    }
    
    /// RGB components for a Color represented as CGFloat numbers (between 0 and 1)
    /// - Returns:
    ///   - red: MGColor.red.rgbComponents
    ///   - green: MGColor.green.rgbComponents
    ///   - blue: MGColor.blue.rgbComponents
    var rgbFloatComponents: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let tuple = rgbaFloatComponents
        return (red: tuple.red, green: tuple.green, blue: tuple.blue)
    }
    
    /// RGB components for a Color represented as CGFloat numbers (between 0 and 1)
    /// - Returns:
    ///   - red: MGColor.red.rgbComponents
    ///   - green: MGColor.green.rgbComponents
    ///   - blue: MGColor.blue.rgbComponents
    ///   - alpha: MGColor.alpha.rgbComponents
    var rgbaFloatComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let components = componentsFloat
        let r = components[0]
        let g = components[1]
        let b = components[2]
        let a = components[3]
        return (red: r, green: g, blue: b, alpha: a)
    }
    
    /// Get components of hue, saturation, and brightness, and alpha (read-only).
    /// - Returns:
    ///   - hue: MGColor.hue.rgbComponents
    ///   - saturation: MGColor.saturation.rgbComponents
    ///   - brightness: MGColor.brightness.rgbComponents
    ///   - alpha: MGColor.alpha.rgbComponents
    var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
                
        origin.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    /// Hexadecimal string type value (read-only).
    var hexString: String {
        let components = componentsInt
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }
    
    /// Short hexadecimal string type value (read-only, if applicable).
    var shortHexString: String? {
        let string = hexString.replacingOccurrences(of: "#", with: "")
        let chrs = Array(string)
        guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else { return nil }
        return "#\(chrs[0])\(chrs[2])\(chrs[4])"
    }
    
    /// Short hexadecimal string type value, or full hexadecimal string type value if not possible (read-only).
    var shortHexOrHexString: String {
        guard let shortHexString = self.shortHexString else {
            return self.hexString
        }
        
        return shortHexString
    }
    
    /// Alpha of Color (read-only).
    var alpha: CGFloat {
        return origin.cgColor.alpha
    }
    
    #if !os(watchOS)
    /// CoreImage.CIColor (read-only)
    var coreImageColor: CoreImage.CIColor? {
        return CoreImage.CIColor(color: origin)
    }
    #endif
    
    /// Get UInt representation of a Color (read-only).
    var uInt: UInt {
        let c = componentsFloat
        
        var colorAsUInt32: UInt32 = 0
        colorAsUInt32 += UInt32(c[0] * 255.0) << 16
        colorAsUInt32 += UInt32(c[1] * 255.0) << 8
        colorAsUInt32 += UInt32(c[2] * 255.0)
        
        return UInt(colorAsUInt32)
    }
    
    /// Get color complementary (read-only, if applicable).
    var complementary: MGColor? {
        let colorSpaceRGB = CGColorSpaceCreateDeviceRGB()
        let convertColorToRGBSpace: ((_ color: MGColor) -> MGColor?) = { color -> MGColor? in
            if origin.cgColor.colorSpace!.model == CGColorSpaceModel.monochrome {
                let oldComponents = origin.cgColor.components
                let components: [CGFloat] = [ oldComponents![0], oldComponents![0], oldComponents![0], oldComponents![1]]
                let colorRef = CGColor(colorSpace: colorSpaceRGB, components: components)
                let colorOut = MGColor(cgColor: colorRef!)
                return colorOut
            } else {
                return origin
            }
        }
        
        let c = convertColorToRGBSpace(origin)
        guard let componentColors = c?.cgColor.components else { return nil }
        
        let r: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[0]*255), 2.0))/255
        let g: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[1]*255), 2.0))/255
        let b: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[2]*255), 2.0))/255
        
        return MGColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    /// Components for CGFloat Array type.
    private var components: [CGFloat] {
        var components: [CGFloat] {
            let c = origin.cgColor.components ?? [0.0, 0.0]
            if c.count == 4 {
                return c
            }
            
            // components of MGColor.clear
            return [c[0], c[0], c[0], c[1]]
        }
        
        return components
    }
    
    /// Components for CGFloat Array type.
    private var componentsFloat: [CGFloat] {
        return components
    }
    
    /// Components for Int Array type.
    private var componentsInt: [Int] {
        let components: [CGFloat] = self.componentsFloat
        return [Int(components[0] * 255),
                Int(components[1] * 255),
                Int(components[2] * 255),
                Int(components[3] * 255)]
    }
    
}

// MARK: - Initializers
public extension MGWrapper_Mg where MGOriginType == MGColor {
    /// Create NSColor from RGB values with optional transparency.
    /// - Parameters:
    ///   - red: Red component.
    ///   - green: Green component.
    ///   - blue: Blue component.
    ///   - transparency: Optional transparency value (default is 1).
    static func `init`(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) -> MGColor? {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        return MGColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    
    /// Create NSColor from hexadecimal value with optional transparency.
    /// - Parameters:
    ///   - hexValue: Hexadecimal Int type value (example: 0xDECEB5).
    ///   - transparency: Optional transparency value (default is 1).
    static func `init`(hexValue: Int, transparency: CGFloat = 1) -> MGColor? {
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        return self.`init`(red: red, green: green, blue: blue, transparency: trans)
    }
    
    /// Create Color from hexadecimal string with optional transparency (if applicable).
    /// - Parameters:
    ///   - hexString: Hexadecimal string (examples: EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F, ..).
    ///   - transparency: Optional transparency value (default is 1).
    static func `init`(hexString: String, transparency: CGFloat) -> MGColor? {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        
        // convert hex to 6 digit format if in short format
        if string.count == 3 {
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        
        guard let hexValue = Int(string, radix: 16) else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        return self.`init`(red: red, green: green, blue: blue, transparency: trans)
    }
    
    /// Create Color from a complementary of a Color (if applicable).
    /// - Parameters
    ///   - color: Color of which opposite color is desired.
    static func `init`(complementaryFor color: MGColor) -> MGColor? {
        let colorSpaceRGB = CGColorSpaceCreateDeviceRGB()
        let convertColorToRGBSpace: ((_ color: MGColor) -> MGColor?) = { color -> MGColor? in
            if color.cgColor.colorSpace!.model == CGColorSpaceModel.monochrome {
                let oldComponents = color.cgColor.components
                let components: [CGFloat] = [ oldComponents![0], oldComponents![0], oldComponents![0], oldComponents![1]]
                let colorRef = CGColor(colorSpace: colorSpaceRGB, components: components)
                let colorOut = MGColor(cgColor: colorRef!)
                return colorOut
            } else {
                return color
            }
        }
        
        let c = convertColorToRGBSpace(color)
        guard let componentColors = c?.cgColor.components else { return nil }
        
        let r: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[0]*255), 2.0))/255
        let g: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[1]*255), 2.0))/255
        let b: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[2]*255), 2.0))/255
        return MGColor.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

public extension MGWrapper_Mg where MGOriginType == MGColor {
    /// The format mode type
    enum HexadecimalNotationMode {
        case rgb
        case rgba
        case argb
        case rrggbb
        case rrggbbaa
        case aarrggbb
        
        public var divisor: Int {
            switch self {
            case .rgb:      return 15
            case .rgba:     return 15
            case .argb:     return 15
            case .rrggbb:   return 255
            case .aarrggbb: return 255
            case .rrggbbaa: return 255
            }
        }
        
        public var digits: Int {
            switch self {
            case .rgb:      return 3
            case .rgba:     return 4
            case .argb:     return 4
            case .rrggbb:   return 6
            case .aarrggbb: return 8
            case .rrggbbaa: return 8
            }
        }
        
        public var hasAlpha: Bool {
            switch self {
            case .rgb:      return false
            case .rgba:     return true
            case .argb:     return true
            case .rrggbb:   return false
            case .aarrggbb: return true
            case .rrggbbaa: return true
            }
        }
        
        public var isShortForm: Bool {
            switch self {
            case .rgb:      return true
            case .rgba:     return true
            case .argb:     return true
            case .rrggbb:   return false
            case .aarrggbb: return false
            case .rrggbbaa: return false
            }
        }
    }
    
    /// Create Color from hexadecimal string with optional transparency (if applicable).
    /// Learn more about [CSS hex color](https://drafts.csswg.org/css-color/#hex-notation)
    /// - Parameters:
    ///   - hexString: hexadecimal string (examples: 0000ffcc, #0000ffcc, EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F, ..).
    ///   - mode: The format model of HexadecimalNotationMode type
    static func `init`(hexString: String, mode: HexadecimalNotationMode = .rrggbb) -> MGColor? {
        let colorString = hexString.mg.replacingOccurrences(of: ["#", "0x"], with: "")
        
        var hexValue: UInt32 = 0
        guard Scanner(string: colorString).scanHexInt32(&hexValue) else {
            return nil
        }
        
        let r, g, b, a: CGFloat
        let divisor: CGFloat = CGFloat(mode.divisor)
        switch mode {
        case .rgb:
            r = CGFloat((hexValue & 0xF00) >> 8) / divisor
            g = CGFloat((hexValue & 0x0F0) >> 4) / divisor
            b = CGFloat( hexValue & 0x00F) / divisor
            a = 1.0
            break
        case .rgba:
            r = CGFloat((hexValue & 0xF000) >> 12) / divisor
            g = CGFloat((hexValue & 0x0F00) >> 8) / divisor
            b = CGFloat((hexValue & 0x00F0) >> 4) / divisor
            a = CGFloat( hexValue & 0x000F) / divisor
            break
        case .argb:
            a = CGFloat((hexValue & 0xF000) >> 12) / divisor
            r = CGFloat((hexValue & 0x0F00) >> 8) / divisor
            g = CGFloat((hexValue & 0x00F0) >> 4) / divisor
            b = CGFloat( hexValue & 0x000F) / divisor
            break
        case .rrggbb:
            r = CGFloat((hexValue & 0xFF0000) >> 16) / divisor
            g = CGFloat((hexValue & 0x00FF00) >> 8) / divisor
            b = CGFloat( hexValue & 0x0000FF) / divisor
            a = 1.0
            break
        case .aarrggbb:
            a = CGFloat((hexValue & 0xFF000000) >> 24) / divisor
            r = CGFloat((hexValue & 0x00FF0000) >> 16) / divisor
            g = CGFloat((hexValue & 0x0000FF00) >> 8) / divisor
            b = CGFloat( hexValue & 0x000000FF) / divisor
            break
        case .rrggbbaa:
            r = CGFloat((hexValue & 0xFF000000) >> 24) / divisor
            g = CGFloat((hexValue & 0x00FF0000) >> 16) / divisor
            b = CGFloat((hexValue & 0x0000FF00) >> 8) / divisor
            a = CGFloat( hexValue & 0x000000FF) / divisor
            break
        }
        #if os(macOS)
        return MGColor(calibratedRed: r, green: g, blue: b, alpha: a)
        #else
        return MGColor(red: r, green: g, blue: b, alpha: a)
        #endif
    }
    
    /// Hexadecimal string type value of MGColor
    /// - Parameters:
    ///   - mode: The format model of HexadecimalNotationMode type
    func hexRepresentation(mode: HexadecimalNotationMode = .rrggbb) -> String {
        let maxi = [HexadecimalNotationMode.rgb, HexadecimalNotationMode.rgba, HexadecimalNotationMode.argb].contains(mode) ? 16 : 256
        
        /// Convert value of f to Int
        /// - Parameters:
        ///   - f: CGFloat type value (between 0 and 1)
        func toI(_ f: CGFloat) -> Int {
            return min(maxi - 1, Int(CGFloat(maxi) * f))
        }
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        origin.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let ri = toI(r)
        let gi = toI(g)
        let bi = toI(b)
        let ai = toI(a)
        
        switch mode {
        case .rgb:       return String(format: "#%X%X%X", ri, gi, bi)
        case .rgba:      return String(format: "#%X%X%X%X", ri, gi, bi, ai)
        case .argb:      return String(format: "#%X%X%X%X", ai, ri, gi, bi)
        case .rrggbb:    return String(format: "#%02X%02X%02X", ri, gi, bi)
        case .rrggbbaa:  return String(format: "#%02X%02X%02X%02X", ri, gi, bi, ai)
        case .aarrggbb:  return String(format: "#%02X%02X%02X%02X", ai, ri, gi, bi)
        }
    }
}
