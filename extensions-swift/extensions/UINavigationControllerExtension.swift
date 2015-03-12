//
//  UINavigationControllerExtension.swift
//  UWifi
//
//  Created by 唐华嶓 on 1/7/15.
//  Copyright (c) 2015 piKey. All rights reserved.
//

import UIKit

extension UINavigationController {
    func popAfterMoment() {
        popAfterMoment(1, viewController: nil)
    }

    func popAfterMoment(interval: NSTimeInterval, viewController: UIViewController?) {
        topViewController.navigationItem.hidesBackButton = true
        TimerUtils.doAfter(Int(interval*1000), block:{ ()->() in
            dispatch_async(dispatch_get_main_queue(), {()->() in
                if viewController != nil {
                    self.popToViewController(viewController!, animated: true)
                } else {
                    self.popViewControllerAnimated(true)
                }
            })
        })
    }

    func popToViewControllerAfterMoment(viewController: UIViewController?) {
        popAfterMoment(1, viewController: viewController)
    }
}
