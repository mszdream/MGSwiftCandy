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
        let r = MGCGFloat(arc4random_uniform(255)) / MGCGFloat(255)
        let g = MGCGFloat(arc4random_uniform(255)) / MGCGFloat(255)
        let b = MGCGFloat(arc4random_uniform(255)) / MGCGFloat(255)
        return MGColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    /// RGB components for a Color (between 0 and 255).
    /// - Returns:
    ///   - red: MGColor.red.rgbComponents
    ///   - green: MGColor.green.rgbComponents
    ///   - blue: MGColor.blue.rgbComponents
    var rgbComponents: (red: MGInt, green: MGInt, blue: MGInt) {
        let tuple = rgbaComponents
        return (red: tuple.red, green: tuple.green, blue: tuple.blue)
    }
    
    /// RGB components for a Color (between 0 and 255).
    /// - Returns:
    ///   - red: MGColor.red.rgbComponents
    ///   - green: MGColor.green.rgbComponents
    ///   - blue: MGColor.blue.rgbComponents
    ///   - alpha: MGColor.alpha
    var rgbaComponents: (red: MGInt, green: MGInt, blue: MGInt, alpha: MGInt) {
        let tuple = rgbaFloatComponents
        return (red: MGInt(tuple.red * 255.0),
                green: MGInt(tuple.green * 255.0),
                blue: MGInt(tuple.blue * 255.0),
                alpha: MGInt(tuple.alpha * 255))
    }
    
    /// RGB components for a Color represented as CGFloat numbers (between 0 and 1)
    /// - Returns:
    ///   - red: MGColor.red.rgbComponents
    ///   - green: MGColor.green.rgbComponents
    ///   - blue: MGColor.blue.rgbComponents
    var rgbFloatComponents: (red: MGCGFloat, green: MGCGFloat, blue: MGCGFloat) {
        let tuple = rgbaFloatComponents
        return (red: tuple.red, green: tuple.green, blue: tuple.blue)
    }
    
    /// RGB components for a Color represented as CGFloat numbers (between 0 and 1)
    /// - Returns:
    ///   - red: MGColor.red.rgbComponents
    ///   - green: MGColor.green.rgbComponents
    ///   - blue: MGColor.blue.rgbComponents
    ///   - alpha: MGColor.alpha.rgbComponents
    var rgbaFloatComponents: (red: MGCGFloat, green: MGCGFloat, blue: MGCGFloat, alpha: MGCGFloat) {
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
    var hsbaComponents: (hue: MGCGFloat, saturation: MGCGFloat, brightness: MGCGFloat, alpha: MGCGFloat) {
        var h: MGCGFloat = 0.0
        var s: MGCGFloat = 0.0
        var b: MGCGFloat = 0.0
        var a: MGCGFloat = 0.0
                
        origin.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    /// Hexadecimal string type value (read-only).
    var hexString: MGString {
        let components = componentsInt
        return MGString(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }
    
    /// Short hexadecimal string type value (read-only, if applicable).
    var shortHexString: MGString? {
        let string = hexString.replacingOccurrences(of: "#", with: "")
        let chrs = MGArray(string)
        guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else { return nil }
        return "#\(chrs[0])\(chrs[2])\(chrs[4])"
    }
    
    /// Short hexadecimal string type value, or full hexadecimal string type value if not possible (read-only).
    var shortHexOrHexString: MGString {
        guard let shortHexString = self.shortHexString else {
            return self.hexString
        }
        
        return shortHexString
    }
    
    /// Alpha of Color (read-only).
    var alpha: MGCGFloat {
        return origin.cgColor.alpha
    }
    
    #if !os(watchOS)
    /// CoreImage.CIColor (read-only)
    var coreImageColor: CoreImage.CIColor? {
        return CoreImage.CIColor(color: origin)
    }
    #endif
    
    /// Get UInt representation of a Color (read-only).
    var uInt: MGUInt {
        let c = componentsFloat
        
        var colorAsUInt32: MGUInt32 = 0
        colorAsUInt32 += MGUInt32(c[0] * 255.0) << 16
        colorAsUInt32 += MGUInt32(c[1] * 255.0) << 8
        colorAsUInt32 += MGUInt32(c[2] * 255.0)
        
        return MGUInt(colorAsUInt32)
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
    private var components: [MGCGFloat] {
        var components: [MGCGFloat] {
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
    private var componentsFloat: [MGCGFloat] {
        return components
    }
    
    /// Components for Int Array type.
    private var componentsInt: [MGInt] {
        let components: [MGCGFloat] = self.componentsFloat
        return [MGInt(components[0] * 255),
                MGInt(components[1] * 255),
                MGInt(components[2] * 255),
                MGInt(components[3] * 255)]
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
    static func `init`(red: MGInt, green: MGInt, blue: MGInt, transparency: MGCGFloat = 1) -> MGColor? {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        return MGColor(red: MGCGFloat(red) / 255.0, green: MGCGFloat(green) / 255.0, blue: MGCGFloat(blue) / 255.0, alpha: trans)
    }
    
    /// Create NSColor from hexadecimal value with optional transparency.
    /// - Parameters:
    ///   - hexValue: Hexadecimal Int type value (example: 0xDECEB5).
    ///   - transparency: Optional transparency value (default is 1).
    static func `init`(hexValue: MGInt, transparency: MGCGFloat = 1) -> MGColor? {
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
    static func `init`(hexString: MGString, transparency: MGCGFloat) -> MGColor? {
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
        
        guard let hexValue = MGInt(string, radix: 16) else { return nil }
        
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
                let components: [MGCGFloat] = [ oldComponents![0], oldComponents![0], oldComponents![0], oldComponents![1]]
                let colorRef = CGColor(colorSpace: colorSpaceRGB, components: components)
                let colorOut = MGColor(cgColor: colorRef!)
                return colorOut
            } else {
                return color
            }
        }
        
        let c = convertColorToRGBSpace(color)
        guard let componentColors = c?.cgColor.components else { return nil }
        
        let r: MGCGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[0]*255), 2.0))/255
        let g: MGCGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[1]*255), 2.0))/255
        let b: MGCGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[2]*255), 2.0))/255
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
        
        public var divisor: MGInt {
            switch self {
            case .rgb:      return 15
            case .rgba:     return 15
            case .argb:     return 15
            case .rrggbb:   return 255
            case .aarrggbb: return 255
            case .rrggbbaa: return 255
            }
        }
        
        public var digits: MGInt {
            switch self {
            case .rgb:      return 3
            case .rgba:     return 4
            case .argb:     return 4
            case .rrggbb:   return 6
            case .aarrggbb: return 8
            case .rrggbbaa: return 8
            }
        }
        
        public var hasAlpha: MGBool {
            switch self {
            case .rgb:      return false
            case .rgba:     return true
            case .argb:     return true
            case .rrggbb:   return false
            case .aarrggbb: return true
            case .rrggbbaa: return true
            }
        }
        
        public var isShortForm: MGBool {
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
    static func `init`(hexString: MGString, mode: HexadecimalNotationMode = .rrggbb) -> MGColor? {
        let colorString = hexString.mg.replacingOccurrences(of: ["#", "0x"], with: "")
        
        var hexValue: MGUInt32 = 0
        guard Scanner(string: colorString).scanHexInt32(&hexValue) else {
            return nil
        }
        
        let r, g, b, a: MGCGFloat
        let divisor: MGCGFloat = MGCGFloat(mode.divisor)
        switch mode {
        case .rgb:
            r = MGCGFloat((hexValue & 0xF00) >> 8) / divisor
            g = MGCGFloat((hexValue & 0x0F0) >> 4) / divisor
            b = MGCGFloat( hexValue & 0x00F) / divisor
            a = 1.0
            break
        case .rgba:
            r = MGCGFloat((hexValue & 0xF000) >> 12) / divisor
            g = MGCGFloat((hexValue & 0x0F00) >> 8) / divisor
            b = MGCGFloat((hexValue & 0x00F0) >> 4) / divisor
            a = MGCGFloat( hexValue & 0x000F) / divisor
            break
        case .argb:
            a = MGCGFloat((hexValue & 0xF000) >> 12) / divisor
            r = MGCGFloat((hexValue & 0x0F00) >> 8) / divisor
            g = MGCGFloat((hexValue & 0x00F0) >> 4) / divisor
            b = MGCGFloat( hexValue & 0x000F) / divisor
            break
        case .rrggbb:
            r = MGCGFloat((hexValue & 0xFF0000) >> 16) / divisor
            g = MGCGFloat((hexValue & 0x00FF00) >> 8) / divisor
            b = MGCGFloat( hexValue & 0x0000FF) / divisor
            a = 1.0
            break
        case .aarrggbb:
            a = MGCGFloat((hexValue & 0xFF000000) >> 24) / divisor
            r = MGCGFloat((hexValue & 0x00FF0000) >> 16) / divisor
            g = MGCGFloat((hexValue & 0x0000FF00) >> 8) / divisor
            b = MGCGFloat( hexValue & 0x000000FF) / divisor
            break
        case .rrggbbaa:
            r = MGCGFloat((hexValue & 0xFF000000) >> 24) / divisor
            g = MGCGFloat((hexValue & 0x00FF0000) >> 16) / divisor
            b = MGCGFloat((hexValue & 0x0000FF00) >> 8) / divisor
            a = MGCGFloat( hexValue & 0x000000FF) / divisor
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
    func hexRepresentation(mode: HexadecimalNotationMode = .rrggbb) -> MGString {
        let maxi = [HexadecimalNotationMode.rgb, HexadecimalNotationMode.rgba, HexadecimalNotationMode.argb].contains(mode) ? 16 : 256
        
        /// Convert value of f to Int
        /// - Parameters:
        ///   - f: CGFloat type value (between 0 and 1)
        func toI(_ f: MGCGFloat) -> MGInt {
            return min(maxi - 1, MGInt(CGFloat(maxi) * f))
        }
        
        var r: MGCGFloat = 0
        var g: MGCGFloat = 0
        var b: MGCGFloat = 0
        var a: MGCGFloat = 0
        
        origin.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let ri = toI(r)
        let gi = toI(g)
        let bi = toI(b)
        let ai = toI(a)
        
        switch mode {
        case .rgb:       return MGString(format: "#%X%X%X", ri, gi, bi)
        case .rgba:      return MGString(format: "#%X%X%X%X", ri, gi, bi, ai)
        case .argb:      return MGString(format: "#%X%X%X%X", ai, ri, gi, bi)
        case .rrggbb:    return MGString(format: "#%02X%02X%02X", ri, gi, bi)
        case .rrggbbaa:  return MGString(format: "#%02X%02X%02X%02X", ri, gi, bi, ai)
        case .aarrggbb:  return MGString(format: "#%02X%02X%02X%02X", ai, ri, gi, bi)
        }
    }
}
