//
//  UIViewControllerExtension.swift
//  UWifi
//
//  Created by 唐华嶓 on 1/21/15.
//  Copyright (c) 2015 piKey. All rights reserved.
//

import UIKit

extension UIViewController {

    /// 在viewWillDisappear方法中调用该方法，可通过该方法判定是否是通过触发返回事件，引起viewWillDisappear
    ///
    /// :returns: 返回true，如果是返回按钮触发，否则返回false
    func isBackActionInNavigation() -> Bool {
        if navigationController != nil {
            return navigationController!.viewControllers.filter({ (item) -> Bool in
                return item === self
            }).count == 0
        }
        return false
    }
}
