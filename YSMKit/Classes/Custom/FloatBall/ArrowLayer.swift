//
//  ArrowLayer.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/1/26.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import UIKit

class ArrowLayer: CALayer {
    
    private let leftArrowImage: UIImage = UIImage(named: "game_floatBall_arrow_l")!
    private let rightArrowImage: UIImage = UIImage(named: "game_floatBall_arrow_r")!
    
    private var currentOrientation: HorizontalOrientation = .left {
        didSet{
            let animat = CABasicAnimation(keyPath: "contents")
            if orientation == .left {
                animat.toValue = leftArrowImage.cgImage
            }else {
                animat.toValue = rightArrowImage.cgImage
            }
            animat.isRemovedOnCompletion = false
            animat.fillMode = kCAFillModeForwards
            animat.duration = 0.1
            self.add(animat, forKey: "rotationArrow")
        }
    }
    
    var orientation: HorizontalOrientation {
        set{
            if currentOrientation != newValue {
                currentOrientation = newValue
            }
        }
        get{
            return currentOrientation
        }
    }
    
    
    override init() {
        super.init()
        self.frame = CGRect(x: 0, y: 0, width: 10, height: 16.5)
        contents = leftArrowImage.cgImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
