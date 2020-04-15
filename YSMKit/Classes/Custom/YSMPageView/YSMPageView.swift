//
//  YSMPageView.swift
//  YSMFactory-swift
//
//  Created by 忆思梦 on 2016/12/5.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

import UIKit

class YSMPageView: NSObject {
    
    fileprivate var titles:[String]
    fileprivate var childVCs:[UIViewController]
    fileprivate var parentVC:UIViewController
    fileprivate var style:YSMPageViewStye
    
    lazy var titleView :YSMPageTitleView = {
        let titleViewFrame = self.style.titleViewFrame
        let titleView = YSMPageTitleView(frame: titleViewFrame, titles: self.titles, style:self.style)
        titleView.delegate = self
        return titleView
    }()
    
    lazy var contentView :YSMPageContentView = {
        let contentViewFrame = self.style.contentViewFrame
        let contentView = YSMPageContentView(frame: contentViewFrame, childVCs: self.childVCs, parentVC: self.parentVC, style:self.style)
        contentView.delegate = self
        return contentView
    }()
    
    init(frame: CGRect ,titles : [String] , viewControllers:[UIViewController] ,parentController:UIViewController, style:YSMPageViewStye) {
        
        assert(titles.count == viewControllers.count, "title与控制器的数目不符")
        assert(viewControllers.count > 0, "至少要有一个控制器")
        
        self.titles = titles;
        self.childVCs = viewControllers;
        self.parentVC = parentController;
        self.style = style;
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YSMPageView:YSMPageTitleViewDelegate,YSMPageContentViewDelegate{
    //YSMPageTitleViewDelegate
    func titleView(_ titleView: YSMPageTitleView, didSelectIndex targetIndex: Int) {
        contentView.set(currentIndex: targetIndex)
    }
    
    //YSMPageContentViewDelegate
    func contentViewDidEndScroll(_ contentView: YSMPageContentView, _ targetIndex: Int) {
        titleView.adjustCurrentLabelCentered(targetIndex)
    }
    func contentView(_ contentView:YSMPageContentView, from currentIndex:Int,scrollingTo targetIndex:Int, _ progress:CGFloat){
        titleView.scrollingTitle(from: currentIndex, to: targetIndex, with: progress)
    }
}

