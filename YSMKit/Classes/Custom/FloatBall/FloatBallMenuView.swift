//
//  FloatBallMenuView.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/1/24.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import UIKit

protocol FloatBallMenuViewDelegate:class {
    func shouldHideMenuAction()
    func floatBallDidClickAction(_ type: FloatBallActionType)
}

class FloatBallMenuView: UIView {

    weak var delegate: FloatBallMenuViewDelegate?
    
    fileprivate var menuItems: [FloatBallMenuItem] = {
        let item1 = FloatBallMenuItem(type: .share, title: "分享", imageName: "game_floatBall_share")
        let item2 = FloatBallMenuItem(type: .attend, title: "签到", imageName: "game_floatBall_sign")
        let item3 = FloatBallMenuItem(type: .exit, title: "退出游戏", imageName: "game_floatBall_logout")
        return [item1, item2, item3]
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 20, height: 27)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 6, left: 0, bottom: 7, right: 0)
        let collectionView = UICollectionView(frame: CGRect(x: 20, y: 0, width: self.menuItems.count*40, height: 40), collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(FloatBallMenuViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    private lazy var rightPath: UIBezierPath = {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 40, y: self.bounds.maxY))
        bezierPath.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 20, startAngle: CGFloat(Double.pi)/2, endAngle: CGFloat(Double.pi)/2*3, clockwise: true)
        bezierPath.addLine(to: CGPoint(x: self.bounds.maxX, y: 0))
        bezierPath.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY))
        bezierPath.close()
        return bezierPath
    }()
    private lazy var leftPath: UIBezierPath = {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: self.bounds.maxY))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: self.bounds.maxX-20, y: 0))
        bezierPath.addArc(withCenter: CGPoint(x: self.bounds.maxX-20, y: 20), radius: 20, startAngle: -CGFloat(Double.pi)/2, endAngle: CGFloat(Double.pi)/2, clockwise: true)
        bezierPath.addLine(to: CGPoint(x: 0, y: self.bounds.maxY))
        bezierPath.close()
        return bezierPath
    }()
    private var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.white.cgColor
        return shapeLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: menuItems.count*40+40, height: 40))
        shapeLayer.path = rightPath.cgPath
        self.layer.addSublayer(shapeLayer)
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let targetView = super.hitTest(point, with: event) {
            return targetView
        }
        delegate?.shouldHideMenuAction()
        return nil
    }
    
    
    func showFrom(_ orientation: HorizontalOrientation, top: CGFloat) {
        var destRect: CGRect
        if orientation == .left {
            collectionView.frame = CGRect(x: 40, y: collectionView.frame.minY, width: collectionView.frame.width, height: collectionView.frame.height)
            self.shapeLayer.path = leftPath.cgPath
            self.frame = CGRect(x: -self.frame.width, y: top, width: self.frame.width, height: self.frame.height)
            destRect = CGRect(x: 0, y: top, width: self.frame.width, height: self.frame.height)
        }else {
            collectionView.frame = CGRect(x: 20, y: collectionView.frame.minY, width: collectionView.frame.width, height: collectionView.frame.height)
            self.shapeLayer.path = rightPath.cgPath
            self.frame = CGRect(x: self.superview!.frame.width, y: top, width: self.frame.width, height: self.frame.height)
            destRect = CGRect(x: self.superview!.frame.width-self.frame.width, y: top, width: self.frame.width, height: self.frame.height)
        }
        isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.frame = destRect
        }
    }
    func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            if self.frame.minX == 0 {
                self.frame = CGRect(x: -self.frame.width, y: self.frame.minY, width: self.frame.width, height: self.frame.height)
            }else {
                self.frame = CGRect(x: self.superview!.frame.width, y: self.frame.minY, width: self.frame.width, height: self.frame.height)
            }
        }) { complete in
            self.isHidden = true
        }
    }
}

extension FloatBallMenuView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FloatBallMenuViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FloatBallMenuViewCell
        let item = menuItems[indexPath.row]
        cell.setup(with: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.shouldHideMenuAction()
        let item: FloatBallMenuItem = menuItems[indexPath.row]
        delegate?.floatBallDidClickAction(item.type)
    }
}
