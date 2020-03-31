//
//  UIImageExtention.swift
//  Prayer
//
//  Created by Apple on 2018/12/2.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit
extension UIImage {
    open func tint(with color: UIColor, alpha: CGFloat, blendmode: CGBlendMode) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        let bounds = CGRect(origin: .zero, size: size)
        UIRectFill(bounds)
        draw(in: bounds, blendMode: blendmode, alpha: alpha)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
