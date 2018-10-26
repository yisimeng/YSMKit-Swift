//
//  SwiftMulticastDelegate.swift
//  SwiftMulticastDelegate
//
//  Created by 忆思梦 on 2017/7/21.
//  Copyright © 2017年 忆思梦. All rights reserved.
//

import UIKit

class SwiftMulticastDelegate<T> {
    
    private var delegateNodes: NSHashTable<AnyObject> = NSHashTable.weakObjects()
    
    func add(_ delegate: T) {
        if !delegateNodes.contains(delegate as AnyObject) {
            delegateNodes.add(delegate as AnyObject)
        }
    }
    
    func remove(_ delegate: T) {
        if delegateNodes.contains(delegate as AnyObject) {
            delegateNodes.remove(delegate as AnyObject)
        }
    }
    
    func invoke(_ invocation: (T) -> ()) {
        for delegate in delegateNodes.allObjects {
            if let delegate = delegate as? T {
                invocation(delegate)
            }
        }
    }
    
}
func += <T>(left: SwiftMulticastDelegate<T>, right: T) {
    left.add(right)
}
func -= <T>(left: SwiftMulticastDelegate<T>, right: T) {
    left.remove(right)
}
