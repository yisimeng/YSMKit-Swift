//
//  String+Extension.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/3/26.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import Foundation

extension String{
    func subString(_ from: Int, _ to: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: from)
        let end = to >= 0 ? self.index(self.startIndex, offsetBy: to) : self.index(self.endIndex, offsetBy: to)
        let range = start..<end
        return String(self[range])
    }
}
