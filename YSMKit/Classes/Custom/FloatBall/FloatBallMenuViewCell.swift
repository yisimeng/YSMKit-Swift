//
//  FloatBallMenuViewCell.swift
//  YSMSwiftTools
//
//  Created by duanzengguang on 2018/1/29.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

import UIKit

class FloatBallMenuViewCell: UICollectionViewCell {
    
    var imageView: UIImageView = UIImageView()
    var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(hex: 0x797979)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(textLabel)
    }
    
    func setup(with item: FloatBallMenuItem) {
        imageView.image = UIImage(named: item.imageName)
        textLabel.text = item.title
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.sizeToFit()
        textLabel.sizeToFit()
        imageView.center = CGPoint(x: bounds.width/2, y: imageView.bounds.height/2)
        textLabel.center = CGPoint(x: bounds.width/2, y: imageView.bounds.maxY+textLabel.bounds.height/2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
