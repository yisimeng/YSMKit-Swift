//
//  DeviceHelper.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2017/12/15.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

import UIKit

protocol DeviceSetable {
}

extension DeviceSetable {
    
    /// 手机定时自动睡眠开关
    ///
    /// - Parameter disable: true：关闭 false：打开
    func setIdleTimer(_ disable: Bool) {
        UIApplication.shared.isIdleTimerDisabled = disable
    }
    
    /// 状态栏忘了请求菊花
    ///
    /// - Parameter visible: true:显示 false:隐藏
    func setNetworkActivityIndicator(_ visible: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = visible
    }
}
