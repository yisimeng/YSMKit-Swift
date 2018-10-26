//
//  Date+Extension.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2017/12/15.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

import Foundation

extension Date {
    
    /// 两个日期是否为同一周
    ///
    /// - Parameter date: <#date description#>
    /// - Returns: <#return value description#>
    func equalWeak(_ date: Date) -> Bool {
        // 间隔大于七天直接返回
        if fabs(self.timeIntervalSince(date)) >= 7*24*3600 {
            return false
        }
        var calender = Calendar.current
        // 设置周一为每周第一天
        calender.firstWeekday = 2
        // 日期为本年第几周
        return calender.ordinality(of: .weekday, in: .year, for: self) == calender.ordinality(of: .weekday, in: .year, for: date)
    }
}
