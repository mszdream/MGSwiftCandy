//
//  MGEventer.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/6/20.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

public class  MGEventer: MGWrapperEnable {
    /// The cache for storing notification related informationThe cache for storing notification related information
    fileprivate var cache: [UInt: [String: NSObjectProtocol]] = [:]
    
    /// Event Handler
    fileprivate struct MGEventerHander {
        /// Event singleton
        static let instance = MGEventer()
        /// Subscribe to and remove queues used by the observer
        static let queue = DispatchQueue(label: "cn.mgeventer.EventBus", attributes: [])
    }

}

public extension MGWrapper_Mg where MGOriginType: MGEventer {
    /// Subscribe notification
    ///
    /// - Parameters:
    ///   - target: An instance of a class.Only one notification with the same name can be registered in the same instance. If multiple notifications are registered, the last one will take effect
    ///   - name: Notification name
    ///   - object: The object that to send the notification, Only the notification sent by this object will be received, and it sent by other objects will be filtered out
    ///   - queue: Perform queue, If it is a non main queue, the handle will be executed in an asynchronous thread, otherwise it will be executed in the main thread
    ///   - handler: Event handling
    @discardableResult
    static func subscribe(_ target: AnyObject,
                          name: String,
                          object: Any? = nil,
                          queue: OperationQueue? = .main,
                          handler: @escaping ((Notification) -> Void)) -> NSObjectProtocol {
        return self.on(target,
                       name: name,
                       object: object,
                       queue: queue,
                       handler: handler)
    }
    
    /// Remove the notification with the specified name under the target
    ///
    /// - Parameters
    ///   - target: An instance of a class,
    ///   - name: The name of the notification
    static func remove(_ target: AnyObject, name: String? = nil) {
        if let name = name {
            self.unregister(target, name: name)
        } else {
            self.unregister(target)
        }
    }

    /// Send a notification
    ///
    /// - Parameter:
    ///   - name: The name of the notification
    ///   - on queue: The queue for sending notifications
    ///   - object: The object to send notifications
    ///   - userInfo: The information carried in notification sending
    static func post(_ name: String,
                     on queue: DispatchQueue? = nil,
                     object: Any? = nil,
                     userInfo: [AnyHashable: Any]? = nil) {
        if let queue = queue {
            queue.async {
                NotificationCenter.default.post(name: Notification.Name(rawValue: name),
                                                object: object,
                                                userInfo: userInfo)
            }
        } else {
            NotificationCenter.default.post(name: Notification.Name(rawValue: name),
                                            object: object,
                                            userInfo: userInfo)
        }
    }
}

// MARK: - private method
private extension MGWrapper_Mg where MGOriginType: MGEventer {
    /// Subscribe notification
    ///
    /// - Parameters:
    ///   - target: An instance of a class.Only one notification with the same name can be registered in the same instance. If multiple notifications are registered, the last one will take effect
    ///   - name: Notification name
    ///   - object: The object that to send the notification, Only the notification sent by this object will be received, and it sent by other objects will be filtered out
    ///   - queue: Perform queue, If it is a non main queue, the handle will be executed in an asynchronous thread, otherwise it will be executed in the main thread
    ///   - handler: Event handling
    @discardableResult
    private static func on(_ target: AnyObject,
                           name: String,
                           object: Any? = nil,
                           queue: OperationQueue? = nil,
                           handler: @escaping ((Notification) -> Void)) -> NSObjectProtocol {
        let center = NotificationCenter.default
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let observer = center.addObserver(forName: NSNotification.Name(rawValue: name),
                                          object: object,
                                          queue: queue,
                                          using: handler)
        
        MGEventer.MGEventerHander.queue.sync {
            if var dicObservers = MGEventer.MGEventerHander.instance.cache[id] {
                if let observer = dicObservers.removeValue(forKey: name) {
                    center.removeObserver(observer)
                }
                
                dicObservers[name] = observer
                MGEventer.MGEventerHander.instance.cache[id] = dicObservers
            } else {
                MGEventer.MGEventerHander.instance.cache[id] = [name: observer]
            }
        }

        return observer
    }
    
    /// Remove all notifications under the target
    /// 
    /// - Parameters
    ///   - target: An instance of a class,
    private static func unregister(_ target: AnyObject) {
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let center = NotificationCenter.default

        MGEventer.MGEventerHander.queue.sync {
            guard let dicObservers = MGEventer.MGEventerHander.instance.cache.removeValue(forKey: id) else {
                return
            }
            
            for (_, observer) in dicObservers.enumerated() {
                center.removeObserver(observer)
            }
        }
    }
    
    /// Remove the notification with the specified name under the target
    ///
    /// - Parameters
    ///   - target: An instance of a class,
    ///   - name: The name of the notification
    private static func unregister(_ target: AnyObject, name: String) {
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let center = NotificationCenter.default

        MGEventer.MGEventerHander.queue.sync {
            guard var dicObservers = MGEventer.MGEventerHander.instance.cache[id] else {
                return
            }
            if let observer = dicObservers.removeValue(forKey: name) {
                center.removeObserver(observer)
                MGEventer.MGEventerHander.instance.cache[id] = dicObservers
            }
        }
    }
}
