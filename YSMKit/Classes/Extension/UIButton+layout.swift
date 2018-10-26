//
//  UIButton+layout.swift
//  Pods
//
//  Created by 忆思梦 on 2017/3/1.
//
//

import UIKit

public enum YSMButtonLayoutStyle {
    case left
    case top
    case right
    case bottom
}

extension UIButton {
    
    public func layout(_ style: YSMButtonLayoutStyle, space: CGFloat = 0) {
        guard buttonType != .system else {
            return
        }
        let imageWidth = self.imageView!.frame.size.width
        let imageHeight = self.imageView!.frame.size.height
        let labelWidth = self.titleLabel!.frame.size.width
        let labelHeight = self.titleLabel!.frame.size.height
        
        switch (style) {
        case .left:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        case .top:
                self.imageEdgeInsets = UIEdgeInsetsMake((-labelHeight)-space/2.0, 0, 0, -labelWidth);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight-space/2.0, 0);
        case .right:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth-space/2.0, 0, imageWidth+space/2.0);
        case .bottom:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
                self.titleEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWidth, 0, 0);
        }
    }

}
