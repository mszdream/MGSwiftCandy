//
//  MG+View+Method.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/31.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

// MARK: - method
public extension MGWrapper_Mg where MGOriginType: MGView {
    /// Background gradient
    /// - Parameters:
    ///   - colors: The color group used by the gradient
    ///   - frame: Location and size of view
    ///   - startPoint: The starting point of the gradient(top left corner is (0, 0), top right corner is (1, 0), bottom left corner is (0, 1), bottom right is corner is (1, 1), the endPoint is same
    ///   - endPoint: The ending point of the gradient
    ///   - mask: Is it used as a mask
    /// - Returns:
    ///   - The layer of the gradient
    @discardableResult
    func gradient(colors: [MGColor],
                  frame: MGCGRect = .zero,
                  startPoint: MGCGPoint = MGCGPoint(x: 0, y: 0),
                  endPoint: MGCGPoint = MGCGPoint(x: 1, y: 0),
                  mask: MGBool = false) -> CALayer? {
        let currentFrame = frame == .zero ? origin.bounds : frame
        guard colors.count >= 2, currentFrame.width > 0, currentFrame.height > 0 else {
            return nil
        }
        
        var gradientColors: [CGColor] = []
        for color in colors {
            gradientColors.append(color.cgColor)
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = currentFrame

        if mask {
            origin.layer.mask = gradientLayer
        } else {
            for subLayer in origin.layer.sublayers ?? [] {
                if subLayer.isKind(of: CAGradientLayer.self) {
                    subLayer.removeFromSuperlayer()
                }
            }

            origin.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        return gradientLayer
    }

    /// Draw fillet
    /// - Parameters:
    ///   - radii: The corner radii
    ///   - rectCorner: Draw that corner
    ///   - frame: Location and size of view
    /// - Returns:
    ///   - The layer of the fillet
    @discardableResult
    func fillet(radii: CGSize = .zero,
                rectCorner: UIRectCorner = .allCorners,
                frame: CGRect = .zero) -> CALayer? {
        let currentFrame = frame == .zero ? origin.bounds : frame
        guard currentFrame.width > 0, currentFrame.height > 0 else {
            return nil
        }
        
        let path = UIBezierPath(roundedRect: currentFrame,
                                byRoundingCorners: rectCorner,
                                cornerRadii: radii)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        origin.layer.mask = shapeLayer
        
        return shapeLayer
    }
    
    /// Draw border
    /// - Parameters:
    ///   - colors:  The color group used by the gradient
    ///   - width: The border width
    ///   - radii: corner radii
    ///   - rectCorner: Draw that corner
    ///   - dash: The pattern of dash line(The first parameter is line width, the second parameter is gap width)
    ///   - frame: Location and size of view
    ///   - startPoint: The starting point of the gradient(top left corner is (0, 0), top right corner is (1, 0), bottom left corner is (0, 1), bottom right is corner is (1, 1), the endPoint is same
    ///   - endPoint: The ending point of the gradient
    /// - Returns:
    ///   - The layer of the border
    @discardableResult
    func border(colors: [UIColor],
                width: CGFloat = 0,
                radii: CGSize = .zero,
                rectCorner: UIRectCorner = .allCorners,
                dash: (NSNumber, NSNumber) = (0, 0),
                frame: CGRect = .zero,
                startPoint: CGPoint = CGPoint(x: 0, y: 0),
                endPoint: CGPoint = CGPoint(x: 1, y: 0)) -> CALayer? {
        let currentFrame = frame == .zero ? origin.bounds : frame
        guard colors.count >= 2, currentFrame.width > 0, currentFrame.height > 0 else {
            return nil
        }
        
        var gradientColors: [CGColor] = []
        for color in colors {
            gradientColors.append(color.cgColor)
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame =  currentFrame
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = gradientColors
        
        let pathFrame = CGRect(x: width / CGFloat(2),
                               y: width / CGFloat(2),
                               width: currentFrame.width -  width,
                               height: currentFrame.height - width)
        let path = UIBezierPath(roundedRect: pathFrame,
                                byRoundingCorners: rectCorner,
                                cornerRadii: radii)
        
        let shape = CAShapeLayer()
        shape.lineWidth = width
        shape.path = path.cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        if dash.0.floatValue > 0 {
            shape.lineDashPattern = [dash.0, dash.1]
        }
        gradientLayer.mask = shape
        
        origin.layer.addSublayer(gradientLayer)
        
        self.fillet(radii: radii, rectCorner: rectCorner, frame: currentFrame)
        
        return gradientLayer
    }
    
}
