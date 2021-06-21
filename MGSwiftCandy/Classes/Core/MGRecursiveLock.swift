//
//  MGRecursiveLock.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/5.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

fileprivate var MGRecursiveLock_lock_key = "MGRecursiveLock_lock_key"

public protocol MGRecursiveLock {}
private extension MGRecursiveLock {
    private var recursiveLock: NSRecursiveLock {
        var lock = objc_getAssociatedObject(self, &MGRecursiveLock_lock_key) as? NSRecursiveLock
        if lock == nil {
            lock = NSRecursiveLock()
            objc_setAssociatedObject(self as Any, &MGRecursiveLock_lock_key, lock, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        return lock!
    }
}

public extension MGRecursiveLock {
    @inline(__always)
    func performLocked<T>(_ action: () -> T) -> T {
        recursiveLock.lock(); defer { self.recursiveLock.unlock() }
        return action()
    }
}

