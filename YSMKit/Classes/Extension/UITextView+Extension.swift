//
//  UITextView+Extension.swift
//  YSMFactory-swift
//
//  Created by 忆思梦 on 2017/6/12.
//  Copyright © 2017年 忆思梦. All rights reserved.
//

import UIKit

private var placeholderKey: Void?
public extension UITextView {
    @IBInspectable var placeholder: String? {
        set {
            guard placeholder != newValue else {
                return
            }
            objc_setAssociatedObject(self, &placeholderKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            if value(forKey: "_placeholderLabel") == nil {
                let placeholderLabel = UILabel(frame: .zero)
                placeholderLabel.text = newValue
                placeholderLabel.textColor = .lightGray
                addSubview(placeholderLabel)
                setValue(placeholderLabel, forKey: "_placeholderLabel")
                if text == "" {
                    text = "."
                    text = ""
                }
                setNeedsDisplay()
            }
        }
        get {
            if let result = objc_getAssociatedObject(self, &placeholderKey) as? String {
                return result
            }
            return nil
        }
    }
}

