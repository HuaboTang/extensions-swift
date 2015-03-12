//
//  NSRegularExpressionExtension.swift
//  UWifi
//
//  Created by 唐华嶓 on 1/26/15.
//  Copyright (c) 2015 piKey. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    public func match(string: String) -> Matcher {
        return Matcher(regular: self, beMatchString: string)
    }
}