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
    var numberOfLines: MGInt {
        get { return origin.titleLabel?.numberOfLines ?? 0 }
        set { origin.titleLabel?.numberOfLines = newValue }
    }
    
    /// set/get normal title
    var titleForNormal: MGString? {
        get { return origin.title(for: .normal) }
        set { origin.setTitle(newValue, for: .normal) }
    }
    /// set/get highlighted title
    var titleForHighlighted: MGString? {
        get { return origin.title(for: .highlighted) }
        set { origin.setTitle(newValue, for: .highlighted) }
    }
    /// set/get selected title
    var titleForSelected: MGString? {
        get { return origin.title(for: .selected) }
        set { origin.setTitle(newValue, for: .selected) }
    }
    /// set/get disabled title
    var titleForDisabled: MGString? {
        get { return origin.title(for: .disabled) }
        set { origin.setTitle(newValue, for: .disabled) }
    }
    
    @available(iOS 9.0, *)
    /// set/get focused title
    var titleForFocused: MGString? {
        get { return origin.title(for: .focused) }
        set { origin.setTitle(newValue, for: .focused) }
    }
    /// set/get application title
    var titleForApplication: MGString? {
        get { return origin.title(for: .application) }
        set { origin.setTitle(newValue, for: .application) }
    }
    /// set/get reserved title
    var titleForReserved: MGString? {
        get { return origin.title(for: .reserved) }
        set { origin.setTitle(newValue, for: .reserved) }
    }
    
    /// set/get normal title color
    var titleColorForNormal: MGColor? {
        get { return origin.titleColor(for: .normal) }
        set { origin.setTitleColor(newValue, for: .normal) }
    }
    /// set/get highlighted title color
    var titleColorForHighlighted: MGColor? {
        get { return origin.titleColor(for: .highlighted) }
        set { origin.setTitleColor(newValue, for: .highlighted) }
    }
    /// set/get selected title color
    var titleColorForSelected: MGColor? {
        get { return origin.titleColor(for: .selected) }
        set { origin.setTitleColor(newValue, for: .selected) }
    }
    /// set/get disabled title color
    var titleColorForDisabled: MGColor? {
        get { return origin.titleColor(for: .disabled) }
        set { origin.setTitleColor(newValue, for: .disabled) }
    }
    
    @available(iOS 9.0, *)
    /// set/get focused title color
    var titleColorForFocused: MGColor? {
        get { return origin.titleColor(for: .focused) }
        set { origin.setTitleColor(newValue, for: .focused) }
    }
    /// set/get application title color
    var titleColorForApplication: MGColor? {
        get { return origin.titleColor(for: .application) }
        set { origin.setTitleColor(newValue, for: .application) }
    }
    /// set/get reserved title color
    var titleColorForReserved: MGColor? {
        get { return origin.titleColor(for: .reserved) }
        set { origin.setTitleColor(newValue, for: .reserved) }
    }
}

// MARK: - image
public extension MGWrapper_Mg where MGOriginType: MGButton {
    /// set/get normal image
    var imageForNormal: MGImage? {
        get { return origin.image(for: .normal) }
        set { origin.setImage(newValue, for: .normal) }
    }
    /// set/get highlighted image
    var imageForHighlighted: MGImage? {
        get { return origin.image(for: .highlighted) }
        set { origin.setImage(newValue, for: .highlighted) }
    }
    /// set/get selected image
    var imageForSelected: MGImage? {
        get { return origin.image(for: .selected) }
        set { origin.setImage(newValue, for: .selected) }
    }
    /// set/get disabled image
    var imageForDisabled: MGImage? {
        get { return origin.image(for: .disabled) }
        set { origin.setImage(newValue, for: .disabled) }
    }
    
    @available(iOS 9.0, *)
    /// set/get focused image
    var imageForFocused: MGImage? {
        get { return origin.image(for: .focused) }
        set { origin.setImage(newValue, for: .focused) }
    }
    /// set/get application image
    var imageForApplication: MGImage? {
        get { return origin.image(for: .application) }
        set { origin.setImage(newValue, for: .application) }
    }
    /// set/get reserved image
    var imageForReserved: MGImage? {
        get { return origin.image(for: .reserved) }
        set { origin.setImage(newValue, for: .reserved) }
    }
    
}

// MARK: - background image
public extension MGWrapper_Mg where MGOriginType: MGButton {
    /// set/get normal background image
    var backgroundImageForNormal: MGImage? {
        get { return origin.backgroundImage(for: .normal) }
        set { origin.setBackgroundImage(newValue, for: .normal) }
    }
    /// set/get highlighted background image
    var backgroundImageForHighlighted: MGImage? {
        get { return origin.backgroundImage(for: .highlighted) }
        set { origin.setBackgroundImage(newValue, for: .highlighted) }
    }
    /// set/get selected background image
    var backgroundImageForSelected: MGImage? {
        get { return origin.backgroundImage(for: .selected) }
        set { origin.setBackgroundImage(newValue, for: .selected) }
    }
    /// set/get disabled background image
    var backgroundImageForDisabled: MGImage? {
        get { return origin.backgroundImage(for: .disabled) }
        set { origin.setBackgroundImage(newValue, for: .disabled) }
    }
    
    @available(iOS 9.0, *)
    /// set/get focused background image
    var backgroundImageForFocused: MGImage? {
        get { return origin.backgroundImage(for: .focused) }
        set { origin.setBackgroundImage(newValue, for: .focused) }
    }
    /// set/get application background image
    var backgroundImageForApplication: MGImage? {
        get { return origin.backgroundImage(for: .application) }
        set { origin.setBackgroundImage(newValue, for: .application) }
    }
    /// set/get reserved background image
    var backgroundImageForReserved: MGImage? {
        get { return origin.backgroundImage(for: .reserved) }
        set { origin.setBackgroundImage(newValue, for: .reserved) }
    }
    
}

// MARK: - background color
public extension MGWrapper_Mg where MGOriginType: MGButton {
    /// set/get normal background color
    var backgroundColor: MGColor? {
        get { return origin.backgroundColor }
        set { origin.backgroundColor = newValue }
    }
    
    /// set/get normal background color
    var backgroundColorForNormal: MGColor? {
        get { return self.backgroundImageForNormal?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForNormal = MGImage.mg.`init`(color: newValue ?? .clear, size: MGCGSize(width: 1, height: 1)) }
    }
    /// set/get highlighted background color
    var backgroundColorForHighlighted: MGColor? {
        get { return self.backgroundImageForHighlighted?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForHighlighted = MGImage.mg.`init`(color: newValue ?? .clear, size: MGCGSize(width: 1, height: 1)) }
    }
    /// set/get selected background color
    var backgroundColorForSelected: MGColor? {
        get { return self.backgroundImageForSelected?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForSelected = MGImage.mg.`init`(color: newValue ?? .clear, size: MGCGSize(width: 1, height: 1)) }
    }
    /// set/get disabled background color
    var backgroundColorForDisabled: MGColor? {
        get { return self.backgroundImageForDisabled?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForDisabled = MGImage.mg.`init`(color: newValue ?? .clear, size: MGCGSize(width: 1, height: 1)) }
    }
    
    @available(iOS 9.0, *)
    /// set/get focused background color
    var backgroundColorForFocused: MGColor? {
        get { return self.backgroundImageForFocused?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForFocused = MGImage.mg.`init`(color: newValue ?? .clear, size: MGCGSize(width: 1, height: 1)) }
    }
    /// set/get application background color
    var backgroundColorForApplication: MGColor? {
        get { return self.backgroundImageForApplication?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForApplication = MGImage.mg.`init`(color: newValue ?? .clear, size: MGCGSize(width: 1, height: 1)) }
    }
    /// set/get reserved background color
    var backgroundColorForReserved: MGColor? {
        get { return self.backgroundImageForReserved?.mg.color(x: 0, y: 0) }
        set { self.backgroundImageForReserved = MGImage.mg.`init`(color: newValue ?? .clear, size: MGCGSize(width: 1, height: 1)) }
    }
    
}
