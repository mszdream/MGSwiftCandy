//
//  MG+ViewController+Extension.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/6.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

extension MGViewController: MGWrapperEnable {}

// MARK: - method
public extension MGWrapper_Mg where MGOriginType: MGViewController {
    /// Get top view controller
    static func topViewController() -> MGViewController? {
        let rootVC = MGApplication.shared.keyWindow?.rootViewController
        var resultVC = self.topViewController(vc: rootVC)
        while resultVC?.presentedViewController != nil {
            resultVC = self.topViewController(vc: resultVC?.presentedViewController)
        }
        return resultVC
    }
    
    fileprivate static func topViewController(vc: MGViewController?) -> MGViewController? {
        if let ctrl = vc as? MGNavigationController {
            return self.topViewController(vc: ctrl.topViewController)
        } else if let ctrl = vc as? MGTabBarController {
            return self.topViewController(vc: ctrl.selectedViewController)
        } else {
            return vc
        }
    }
}

// MARK: - Storyboard
public extension MGWrapper_Mg where MGOriginType: MGViewController {
    /// The storyboardId of the controller in the storyboard, The default name is the same with class name, If not, please override this method in the controller
    static var storyboardId: MGString {
        let idr = NSStringFromClass(MGOriginType.self).components(separatedBy: ".").last!
        return idr
    }
    
    /// The name of the storyboard where the controller is located. The default value is "" and this method needs to be overridden in the controller
    static var storyboardName: MGString {
        return ""
    }
    
    /// The controller is created by the name of the storyboard and the controller's id in the storyboard
    static func createVCFromSb() -> Self? {
        guard let vc = self.instance(storyboard: self.storyboardName, identifier: self.storyboardId) else {
            return nil
        }
        
        return vc
    }
    
    
    private static func instance(storyboard sbname: MGString, bundle: Bundle? = nil, identifier: MGString?) -> Self? {
        return self._instance(storyboard: sbname, bundle: bundle, identifier: identifier)
    }
    
    private static func _instance<T>(storyboard sbname: MGString, bundle: Bundle?, identifier: MGString?) -> T? {
        let storyboard = UIStoryboard.init(name: sbname, bundle: bundle)
        guard let id = identifier else {
            return storyboard.instantiateInitialViewController() as? T
        }
        return storyboard.instantiateViewController(withIdentifier: id) as? T
    }
    
}

