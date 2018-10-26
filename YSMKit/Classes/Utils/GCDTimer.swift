//
//  GCDTimer.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/2/6.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import UIKit

class GCDTimer {
    
    var source: DispatchSourceTimer?
    var handler: (()->())?
    
    class func scheduled(time interval: TimeInterval, block: (()->())?) -> GCDTimer {
        let timer = GCDTimer()
        timer.source = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        timer.source?.scheduleOneshot(deadline: .now()+interval)
//        timer.source.schedule(deadline: .now()+interval)
        timer.handler = block
        timer.source?.setEventHandler(handler: timer.handler)
        return timer
    }
    
    func resume() {
        source?.resume()
    }
    func suspend() {
        source?.suspend()
    }
    func cancel() {
        source?.cancel()
        handler = nil
        source = nil
    }
    deinit {
        cancel()
    }
}
