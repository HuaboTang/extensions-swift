//
//  UIImageExtension.swift
//  UWifi
//
//  Created by 唐华嶓 on 1/6/15.
//  Copyright (c) 2015 piKey. All rights reserved.
//

import UIKit

extension UIImage {
    class func defaultAvatar() -> UIImage {
        return UIImage(named: "defAvatar")!
    }

    class func defaultShopAvatar() -> UIImage {
        return UIImage(named: "defaultShopAvatar")!
    }

    func imageWithScale(scale: CGFloat) -> UIImage {
        return UIImage(CGImage: self.CGImage, scale: scale, orientation: UIImageOrientation.Up)!
    }

    func scaleImageForSize(scaleSize: CGFloat) -> UIImage {
        let scaledWidth = self.size.width * scaleSize
        let scaledHeight = self.size.height * scaleSize
        UIGraphicsBeginImageContext(CGSizeMake(scaledWidth, scaledHeight))
        self.drawInRect(CGRectMake(0, 0, scaledWidth, scaledHeight))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }

    func data() -> NSData! {
        let png = UIImagePNGRepresentation(self)
        if png == nil {
            return UIImageJPEGRepresentation(self, 1)
        } else {
            return png
        }
    }
}