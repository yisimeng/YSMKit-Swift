//
//  UIImage+Extension.swift
//  Pods-YSMCategory_Example
//
//  Created by 忆思梦 on 2017/7/24.
//

import UIKit

extension UIImage{
    
    /// 图片是否有alpha通道
    var hasAlphaChannel: Bool? {
        get {
            guard let alpha = cgImage?.alphaInfo else {
                return nil
            }
            return (alpha == .first || alpha == .last || alpha == .premultipliedLast || alpha == .premultipliedFirst)
        }
    }
}
