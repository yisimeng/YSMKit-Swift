//
//  FloatBall.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/1/25.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import UIKit

protocol FloatBallProtocol: class {
    func floatBallAction(_ type: FloatBallActionType)
}

enum FloatBallActionType {
    case share, attend, exit
}

enum HorizontalOrientation {
    case left, right
}

class FloatBall {
    
    weak var delegate: FloatBallProtocol?
    
    fileprivate var button: FloatButton = {
        let btn = FloatButton(frame: CGRect(x: UIScreen.main.bounds.width-20, y: 100, width: 20, height: 40))
        return btn
    }()
    fileprivate var menuView: FloatBallMenuView = {
        let menuView = FloatBallMenuView(frame: CGRect.zero)
        menuView.isHidden = true
        return menuView
    }()
    
    init() {
        button.delegate = self
        menuView.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // public
    func show(`super` view: UIView) {
        menuView.frame = CGRect(x: view.bounds.width, y: 0, width: menuView.frame.width, height: menuView.frame.height)
        view.addSubview(menuView)
        view.addSubview(button)
    }
    func hide() {
        menuView.removeFromSuperview()
        button.removeFromSuperview()
    }
}

extension FloatBall: FloatButtonDelegate, FloatBallMenuViewDelegate{
    func shouldHideMenuAction() {
        if button.isSelected {
            button.changeSelectedState()
            menuView.hide()
        }
    }
    
    func floatButtonDidClick(_ button: FloatButton, isSelected: Bool) {
        if isSelected {
            menuView.showFrom(button.currentSide, top: button.frame.minY)
        }else {
            menuView.hide()
        }
    }
    
    func floatBallDidClickAction(_ type: FloatBallActionType) {
        delegate?.floatBallAction(type)
    }
}

