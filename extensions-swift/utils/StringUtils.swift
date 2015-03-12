//
//  StringUtils.swift
//  UWifi
//
//  Created by 唐华嶓 on 1/6/15.
//  Copyright (c) 2015 piKey. All rights reserved.
//

import Foundation

public class StringUtils {

    /// Return true if the "value" String is not null and not empty
    public class func isNotBlank(value: String?) -> Bool {
        return value != nil && !value!.isEmpty
    }

    /// Return true if the "value" is a not empty String
    public class func isNotBlankString(value: AnyObject?) -> Bool {
        return value != nil && value is String && !(value as String).isEmpty
    }

    /// Return either the passed in optinal String, or if the string is null, an empty string ""
    ///
    /// :param: str the string to check, may be null
    /// :returns: the passed String, or a empty String "" if it is null
    public class func notNullString(str: String?) -> String {
        return notNullString(str, defaultStr: "")
    }

    /// Return either the passed in optional String, or if the string is null, the value of defaultStr
    ///
    /// :param: str the string to check, may be null
    /// :param: the default string to return, if the str is null
    /// :returns: the passed String, or the defaultStr if it is null
    public class func notNullString(str: String?, defaultStr: String) -> String {
        return str == nil ? defaultStr : str!
    }

    public class func notBlankString(str: String?, defaultStr: String) -> String {
        return self.isNotBlank(str) ? str! : defaultStr
    }

    public class func stringWithDeviceToken(deviceToken: NSData) -> String {
        let dev = deviceToken.description as NSString
        let realDeviceToken = dev.stringByReplacingOccurrencesOfString("<", withString: "").stringByReplacingOccurrencesOfString(">", withString: "", options: nil, range: nil).stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil);
        return realDeviceToken
    }
}