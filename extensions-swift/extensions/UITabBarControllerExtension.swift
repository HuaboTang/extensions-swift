//
//  UITabBarControllerExtension.swift
//  UWifi
//
//  Created by 唐华嶓 on 2/2/15.
//  Copyright (c) 2015 piKey. All rights reserved.
//

import UIKit

private let badgeImage = UIImage(named: "tabbarBadge")

extension UITabBarController {

    func addBadgeForItemAtIndex(index: Int) {
        let countOfItems = NumberUtils.notNullInt(self.tabBar.items?.count)
        assert(countOfItems > index && index >= 0)

        let badgeIndex = CGFloat(index)

        let frame = tabBar.frame
        let eachWidth = frame.width / CGFloat(countOfItems)
        let x = (eachWidth * badgeIndex + eachWidth / 2) + 15
        let badgeView = UIImageView(frame: CGRect(x: ceil(x), y: 5, width: 6, height: 6))
        badgeView.backgroundColor = UIColor.clearColor()
        badgeView.image = UIImage(named: "tabbarBadge")
        badgeView.tag = tagOfBadgeView(index)
        self.tabBar.addSubview(badgeView)
    }

    private func tagOfBadgeView(index: Int) -> Int {
        let countOfItems = NumberUtils.notNullInt(self.tabBar.items?.count)
        assert(countOfItems > 0 && countOfItems > index && index >= 0)

        return 1000 + countOfItems*100 + index*10 + 5
    }

    func removeBadgeForItemAtIndex(index: Int) {
        let tag = tagOfBadgeView(index)
        let view = tabBar.viewWithTag(tag)
        if let v = view {
            v.removeFromSuperview()
        }
    }
}
