//
//  YSMUtils.swift
//  YSMSwiftTools
//
//  Created by 马彬彬 on 2017/9/12.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

import UIKit


extension Array {
    func value(for index: Int) throws -> Element {
        guard index < count, index >= 0 else {
            throw NSError(domain: "下标越界", code: 1000, userInfo: ["count": count, "index": index])
        }
        return self[index]
    }
}

// MARK: - 延时方法
//定义类型
typealias Task = (_ cancel : Bool) -> Void

func delay(_ time : TimeInterval, task :@escaping()->()) -> Task? {
    func dispatch_later(block: @escaping ()->()){
        let t = DispatchTime.now()+time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        print("1")
    }
    
    var closure: (()->Void)? = task
    var result:Task?
    print("2")
    let delayedClosure:Task = {cancel in
        if let internalClosure = closure {
            if (cancel == false){
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
        print("3")
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result{
            delayedClosure(false)
            print("4")
        }
    }
    
    return result
}
func cancel(_ task: Task?){
    task?(true)
}
