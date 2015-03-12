//
//  StringUtils.swift
//  UWifi
//
//  Created by 唐华嶓 on 12/29/14.
//  Copyright (c) 2014 piKey. All rights reserved.
//

import UIKit

public class NumberUtils {

    /// Convert a String Value to a Int, return 0 if the conversion fails.
    ///
    /// :param: value the string to convert, may be nil
    /// :return: the int represented by the string, or zero if converion fails
    public class func toInt(value: String?) -> Int {
        return toInt(value, defValue: 0)
    }

    /// Convert a String value to a Int, return the defValue if the conversion fails.
    ///
    /// :param: the string to convert, may be nil
    /// :param: the default value
    /// :return: the int represented by the string, or defValue if conversion fails
    public class func toInt(value: String?, defValue: Int) -> Int {
        if value == nil {
            return defValue
        } else {
            let iValue = value?.toInt()
            return iValue == nil ? defValue : iValue!
        }
    }

    /// Return the Int value of "value" if it is not null, else return 0
    public class func notNullInt(value: Int?) -> Int {
        return notNullInt(value, defaultValue: 0)
    }

    /// Return the Int value of "value" if it is not null, else return defaultValue
    public class func notNullInt(value: Int?, defaultValue: Int) -> Int {
        return value == nil ? defaultValue : value!
    }

    public class func notNullNumber(value: CGFloat?) -> CGFloat {
        return notNullNumber(value, defaultValue: 0)
    }

    public class func notNullNumber(value: CGFloat?, defaultValue: CGFloat) -> CGFloat {
        return value == nil ? defaultValue : value!
    }

    public class func max(val1: Int, val2: Int) -> Int {
        return val1 > val2 ? val1 : val2
    }

    public class func max(val1: CGFloat, val2: CGFloat) -> CGFloat {
        return val1 > val2 ? val1 : val2
    }
}