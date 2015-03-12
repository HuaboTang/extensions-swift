//
//  UIAlertExtension.swift
//  UWifi
//
//  Created by 唐华嶓 on 12/27/14.
//  Copyright (c) 2014 piKey. All rights reserved.
//

import UIKit

extension UIAlertView {
    class func alert(message: String, delegate: UIAlertViewDelegate?, tag: Int) {
        let alert = UIAlertView(title: "提示", message: message, delegate: delegate,
            cancelButtonTitle: "确定")
        alert.tag = tag
        alert.show()
    }

    class func alert(message: String) {
        self.alert(message, delegate: nil, tag:1)
    }
}