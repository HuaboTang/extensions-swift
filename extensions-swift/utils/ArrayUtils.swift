//
//  ArrayUtils.swift
//  UWifi
//
//  Created by 唐华嶓 on 1/28/15.
//  Copyright (c) 2015 piKey. All rights reserved.
//

import UIKit

public class ArrayUtils {

    /// Return ture if the array is not null and not empty, else return false
    public class func notEmpty<T: AnyObject>(array: Array<T>?) -> Bool {
        return array != nil && array!.count > 0
    }

    public class func isEmpty<T: AnyObject>(array: Array<T>?) -> Bool {
        return !self.notEmpty(array)
    }
}
