//
//  CGRect+Extension.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2017/12/15.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGRect {
    
    /// 转换成文本的rect
    ///
    /// - Returns: <#return value description#>
    func formatterTextRect() -> CGRect {
        let formatter = NumberFormatter()
        // 1位小数
        formatter.maximumFractionDigits = 1
        // 增量设置为0.5
        formatter.roundingIncrement = 0.5
        // 向上取整
        formatter.roundingMode = NumberFormatter.RoundingMode.up
        let result: CGRect = CGRect(x: NSNumber(value: Double(self.minX)).doubleValue, y: NSNumber(value: Double(self.minX)).doubleValue, width: NSNumber(value: Double(self.minX)).doubleValue, height: NSNumber(value: Double(self.minX)).doubleValue)
        return result
    }
}
