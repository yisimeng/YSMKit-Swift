//
//  FloatButton.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/1/25.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import UIKit

protocol FloatButtonDelegate: class {
    func floatButtonDidClick(_ button: FloatButton, isSelected: Bool)
}


class FloatButton: UIView, UIScrollViewDelegate {
    
    private(set) var currentSide: HorizontalOrientation = .right
    private var isMove: Bool = false
    private var beginPoint: CGPoint = CGPoint.zero
    
    fileprivate var arrowLayer: ArrowLayer = ArrowLayer()
    weak var delegate: FloatButtonDelegate?
    private(set) var isSelected: Bool = false{
        didSet{
            delegate?.floatButtonDidClick(self, isSelected: isSelected)
            if currentSide == .right {
                if isSelected == true {
                    arrowLayer.orientation = .right
                }else {
                    arrowLayer.orientation = .left
                }
            }else {
                if isSelected == true {
                    arrowLayer.orientation = .left
                }else {
                    arrowLayer.orientation = .right
                }
            }
        }
    }
    fileprivate var aniLayer: CAShapeLayer = CAShapeLayer()
    fileprivate lazy var rightPath: UIBezierPath = {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        bezierPath.addArc(withCenter: CGPoint(x: self.bounds.maxX, y: self.bounds.height/2), radius: self.bounds.width, startAngle: CGFloat(Double.pi)/2, endAngle: CGFloat(Double.pi)/2*3, clockwise: true)
        bezierPath.close()
        return bezierPath
    }()
    fileprivate lazy var leftPath: UIBezierPath = {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addArc(withCenter: CGPoint(x: 0, y: self.bounds.height/2), radius: self.bounds.width, startAngle: CGFloat(Double.pi)/2, endAngle: -CGFloat(Double.pi)/2, clockwise: false)
        bezierPath.close()
        return bezierPath
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        aniLayer.path = rightPath.cgPath
        layer.mask = aniLayer
        
        
        let gradientLayer = CAGradientLayer(layer: aniLayer)
        // 图层的颜色空间(阶梯显示时按照数组的顺序显示渐进色)
        gradientLayer.colors = [UIColor(hex: 0xff7031).cgColor,UIColor(hex: 0xff3533).cgColor]
        gradientLayer.locations = [0,1]
        gradientLayer.frame = bounds
        gradientLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        // 绘图的起点(默认是(0.5,0))
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        // 绘图的终点(默认是(0.5,1))
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        layer.addSublayer(gradientLayer)

        arrowLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        layer.addSublayer(arrowLayer)
        
        addTarget(target: self, action: #selector(changeSelectedState))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let point = touches.first?.location(in: self) else { return }
        isMove = false
        beginPoint = point
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let current: CGPoint = touches.first?.location(in: self) else {return}
        let delta_x = current.x-beginPoint.x
        let delta_y = current.y-beginPoint.y
        guard fabsf(Float(delta_x)) > 3 || fabsf(Float(delta_y)) > 3 else {return}
        isSelected = false
        isMove = true
        floatBallDidMoved(x: delta_x, y: delta_y)
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isMove == true else {
            isSelected = !isSelected
            return
        }
        let endPoint = floatBallDidEndMoveTo()
        if endPoint.x < UIScreen.main.bounds.width/2 {
            if currentSide != .left {
                rotationButton(true)
                arrowLayer.orientation = .right
            }
            currentSide = .left
        }else {
            if currentSide != .right {
                rotationButton(false)
                arrowLayer.orientation = .left
            }
            currentSide = .right
        }
        if !self.center.equalTo(endPoint) {
            endMove(to: endPoint, isBounce: true)
        }
    }
    
    // 移动
    fileprivate func floatBallDidMoved(x deltaX: CGFloat, y deltaY: CGFloat) {
        self.center = CGPoint(x: center.x+deltaX, y: center.y+deltaY)
    }
    // 移动结束后停靠的位置
    fileprivate func floatBallDidEndMoveTo() -> CGPoint {
        var side_x: CGFloat
        var side_y: CGFloat
        if (self.center.x < UIScreen.main.bounds.size.width/2) {
            // 靠左
            side_x = self.frame.size.width/2;

        }else{
            // 靠右
            side_x = UIScreen.main.bounds.size.width-self.frame.size.width/2;
        }
        // 上下边界
        if (self.center.y < 20 + self.frame.size.height/2) {
            side_y = 20 + self.frame.size.height/2;
        }else if (self.center.y > UIScreen.main.bounds.size.height-10-self.frame.size.height/2) {
            side_y = UIScreen.main.bounds.size.height-10-self.frame.size.height/2;
        }else {
            side_y = self.center.y;
        }
        // 最终位置
        let sidePoint = CGPoint(x: side_x, y: side_y)
        return sidePoint
    }
    
    @objc func changeSelectedState() {
        isSelected = !isSelected
    }
    
}

extension FloatButton{
    /// 悬浮球拖拽后动画
    ///
    /// - Parameters:
    ///   - point: <#point description#>
    ///   - isBounce: <#isBounce description#>
    fileprivate func endMove(to point: CGPoint, isBounce: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveLinear, animations: {
            self.center = point
        }, completion: nil)
    }
    
    func rotationButton(_ isSelected: Bool) {
        let animat = CABasicAnimation(keyPath: "path")
        if isSelected {
            animat.toValue = leftPath.cgPath
        }else {
            animat.toValue = rightPath.cgPath
        }
        animat.isRemovedOnCompletion = false
        animat.fillMode = kCAFillModeForwards
        animat.duration = 0.01
        aniLayer.add(animat, forKey: "rotationButton")
    }
}
