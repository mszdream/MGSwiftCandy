//
//  MG+String+AttributedString.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/6/15.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

public extension MGWrapper_Mg where MGOriginType == MGString {
    /// Convert string to rich text
    ///
    /// - Parameters:
    ///   - font: Font
    ///   - color: Font color
    ///   - style: Font offset and other style adjustment
    /// - Returns: Rich text
    func toAttributedString(_ font: UIFont = UIFont.systemFont(ofSize: 15),
                            _ color: UIColor = UIColor.black,
                            _ style: NSMutableParagraphStyle? = nil) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [.font: font,
                                                         .foregroundColor: color]
        let attributedString = NSMutableAttributedString.init(string: origin,
                                                              attributes: attributes)
        if  style != nil {
            let range = NSRange.init(location: 0, length: attributedString.length)
            attributedString.addAttributes([.paragraphStyle: style!], range: range)
        }
        
        return attributedString
    }
    
    /// Get rich text size
    /// - Parameters:
    ///   - lineSpeace: row height
    ///   - font: The font of text
    ///   - maxWidth: The maximum width
    ///   - maxHeight: The maximum height
    /// - Returns: The size of the rich text
    func getAttributedStringSize(lineSpeace: CGFloat = 20,
                                 font: UIFont = UIFont.systemFont(ofSize: 15),
                                 maxWidth: CGFloat = UIScreen.main.bounds.width,
                                 maxHeight: CGFloat = UIScreen.main.bounds.height) -> CGSize {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = lineSpeace
        
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.paragraphStyle: paraStyle]

        let nsString = NSString(cString: origin, encoding: String.Encoding.utf8.rawValue)!

        let size = nsString.boundingRect(with: CGSize(width: maxWidth, height: maxHeight),
                                         options: [.usesLineFragmentOrigin, .usesFontLeading],
                                         attributes: attributes,
                                         context: nil).size

        return size
    }

}

