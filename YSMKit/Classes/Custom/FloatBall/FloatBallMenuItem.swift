//
//  FloatBallMenuItem.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/1/24.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import UIKit

class FloatBallMenuItem {
    
    var type: FloatBallActionType
    var title: String = ""
    var imageName: String = ""
    
    init(type: FloatBallActionType, title: String, imageName: String) {
        self.type = type
        self.title = title
        self.imageName = imageName
    }
}
