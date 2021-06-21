//
//  MG+Button+Extension.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/5.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

// MARK: - title
public extension MGWrapper_Mg where MGOriginType: MGButton {
    /// set/get number of lines
    var numberOfLines: Int {
        get { return origin.titleLabel?.numberOfLines ?? 0 }
        set { origin.titleLabel?.numberOfLines = newValue }
    }
    
    /// set/get normal title
    var titleForNormal: String? {
        get { return origin.title(for: .normal) }
        set { origin.setTitle(newValue, for: .normal) }
    }
    /// set/get highlighted title
    var titleForHighlighted: String? {
        get { return origin.title(for: .highlighted) }
        set { origin.setTitle(newValue, for: .highlighted) }
    }
    /// set/get selected title
    var titleForSelected: String? {
        get { return origin.title(for: .selected) }
        set { origin.setTitle(newValue, for: .selected) }
    }
    /// set/get disabled title
    var titleForDisabled: String? {
        get { return origin.title(for: .disabled) }
        set { origin.setTitle(newValue, for: .disabled) }
    }
    
    @available(iOS 9.0, *)
    /// set/get focused title
    var titleForFocused: String? {
        get { return origin.title(for: .focused) }
        set { origin.setTitle(newValue, for: .focused) }
    }
    /// set/get application title
    var titleForApplication: String? {
        get { return origin.title(for: .application) }
        set { origin.setTitle(newValue, for: .application) }
    }
    /// set/get reserved title
    var titleForReserved: String? {
        get { return origin.title(for: .reserved) }
        set { origin.setTitle(newValue, for: .reserved) }
    }
    
    /// set/get normal title color
    var titleColorForNormal: UIColor? {
        get { return origin.titleColor(for: .normal) }
        set { origin.setTitleColor(newValue, for: .normal) }
    }
    /// set/get highlighted title color
    var titleColorForHighlighted: UIColor? {
        get { return origin.titleColor(for: .highlighted) }
        set { origin.setTitleColor(newValue, for: .highlighted) }
    }
    /// set/get selected title color
    var titleColorForSelected: UIColor? {
        get { return origin.titleColor(for: .selected) }
        set { origin.setTitleColor(newValue, for: .selected) }
    }
    /// set/get disabled title color
    var titleColorForDisabled: UIColor? {
        get { return origin.titleColor(for: .disabled) }
        set { origin.setTitleColor(newValue, for: .disabled) }
    }
    
    @available(iOS 9.0, *)
    /// set/get focused title color
    var titleColorForFocused: UIColor? {
        get { return origin.titleColor(for: .focused) }
        set { origin.setTitleColor(newValue, for: .focused) }
    }
    /// set/get application title color
    var titleColorForApplication: UIColor? {
        get { return origin.titleColor(for: .application) }
        set { origin.setTitleColor(newValue, for: .application) }
    }
    /// set/get reserved title color
    var titleColorForReserved: UIColor? {
        get { return origin.titleColor(for: .reserved) }
        set { origin.setTitleColor(newValue, for: .reserved) }
    }
}

// MARK: - image
public extension MGWrapper_Mg where MGOriginType: MGButton {
    /// set/get normal image
    var imageForNormal: UIImage? {
        get { return origin.image(for: .normal) }
        set { origin.setImage(newValue, for: .normal) }
    }
    /// set/get highlighted image
    var imageForHighlighted: UIImage? {
        get { return origin.image(for: .highlighted) }
        set { origin.setImage(newValue, for: .highlighted) }
    }
    /// set/get selected image
    var imageForSelected: UIImage? {
        get { return origin.image(for: .selected) }
        set { origin.setImage(newValue, for: .selected) }
    }
    /// set/get disabled image
    var imageForDisabled: UIImage? {
        get { return origin.image(for: .disabled) }
        set { origin.setImage(newValue, for: .disabled) }
    }
    
    @available(iOS 9.0, *)
    /// set/get focused image
    var imageForFocused: UIImage? {
        get { return origin.image(for: .focused) }
        set { origin.setImage(newValue, for: .focused) }
    }
    /// set/get application image
    var imageForApplication: UIImage? {
        get { return origin.image(for: .application) }
        set { origin.setImage(newValue, for: .application) }
    }
    /// set/get reserved image
    var imageForReserved: UIImage? {
        get { return origin.image(for: .reserved) }
        set { origin.setImage(newValue, for: .reserved) }
    }
    
}

// MARK: - background image
public extension MGWrapper_Mg where MGOriginType: MGButton {
    /// set/get normal background image
    var backgroundImageForNormal: UIImage? {
        get { return origin.backgroundImage(for: .normal) }
        set { origin.setBackgroundImage(newValue, for: .normal) }
    }
    /// set/get highlighted background image
    var backgroundImageForHighlighted: UIImage? {
        get { return origin.backgroundImage(for: .highlighted) }
        set { origin.setBackgroundImage(newValue, for: .highlighted) }
    }
    /// set/get selected background image
    var backgroundImageForSelected: UIImage? {
        get { return origin.backgroundImage(for: .selected) }
        set { origin.setBackgroundImage(newValue, for: .selected) }
    }
    /// set/get disabled background image
    var backgroundImageForDisabled: UIImage? {
        get { return origin.backgroundImage(for: .disabled) }
        set { origin.setBackgroundImage(newValue, for: .disabled) }
    }
    
    @available(iOS 9.0, *)
    /// set/get focused background image
    var backgroundImageForFocused: UIImage? {
        get { return origin.backgroundImage(for: .focused) }
        set { origin.setBackgroundImage(newValue, for: .focused) }
    }
    /// set/get application background image
    var backgroundImageForApplication: UIImage? {
        get { return origin.backgroundImage(for: .application) }
        set { origin.setBackgroundImage(newValue, for: .application) }
    }
    /// set/get reserved background image
    var backgroundImageForReserved: UIImage? {
        get { return origin.backgroundImage(for: .reserved) }
        set { origin.setBackgroundImage(newValue, for: .reserved) }
    }
    
}

// MARK: - background color
public extension MGWrapper_Mg where MGOriginType: MGButton {
    /// set/get normal background color
    var backgroundColor: UIColor? {
        get { return origin.backgroundColor }
        set { origin.backgroundColor = newValue }
    }
    
    /// set/get normal background color
    var backgroundColorForNormal: UIColor? {
        get { return self.backgroundImageForNormal?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForNormal = UIImage.mg.`init`(color: newValue ?? .clear, size: CGSize(width: 1, height: 1)) }
    }
    /// set/get highlighted background color
    var backgroundColorForHighlighted: UIColor? {
        get { return self.backgroundImageForHighlighted?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForHighlighted = UIImage.mg.`init`(color: newValue ?? .clear, size: CGSize(width: 1, height: 1)) }
    }
    /// set/get selected background color
    var backgroundColorForSelected: UIColor? {
        get { return self.backgroundImageForSelected?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForSelected = UIImage.mg.`init`(color: newValue ?? .clear, size: CGSize(width: 1, height: 1)) }
    }
    /// set/get disabled background color
    var backgroundColorForDisabled: UIColor? {
        get { return self.backgroundImageForDisabled?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForDisabled = UIImage.mg.`init`(color: newValue ?? .clear, size: CGSize(width: 1, height: 1)) }
    }
    
    @available(iOS 9.0, *)
    /// set/get focused background color
    var backgroundColorForFocused: UIColor? {
        get { return self.backgroundImageForFocused?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForFocused = UIImage.mg.`init`(color: newValue ?? .clear, size: CGSize(width: 1, height: 1)) }
    }
    /// set/get application background color
    var backgroundColorForApplication: UIColor? {
        get { return self.backgroundImageForApplication?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForApplication = UIImage.mg.`init`(color: newValue ?? .clear, size: CGSize(width: 1, height: 1)) }
    }
    /// set/get reserved background color
    var backgroundColorForReserved: UIColor? {
        get { return self.backgroundImageForReserved?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForReserved = UIImage.mg.`init`(color: newValue ?? .clear, size: CGSize(width: 1, height: 1)) }
    }
    
}
