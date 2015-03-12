//
//  StringExtension.swift
//  UWifi
//
//  Created by 唐华嶓 on 12/27/14.
//  Copyright (c) 2014 piKey. All rights reserved.
//

import Foundation

let mobilePhoneNumRegex = "[0-9]{11}"
public extension String {

    /// Return length of this String value by encoding with UTF8
    var length: Int {
        return self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    }

    /// Return true if this String is a mobile phone number
    func isMobilePhoneNumber() -> Bool {
        let mobilePhoneNumTest = NSPredicate(format: "SELF MATCHES %@", mobilePhoneNumRegex)
        return mobilePhoneNumTest!.evaluateWithObject(self)
    }

    func utf8String() -> UnsafePointer<Int8> {
        return (self as NSString).UTF8String
    }

    static func currentVersion() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as String
    }

    /// Return a empty string "" if the "str" is nil, or return the "str" value
    static func notNullString(str: String?) -> String {
        return str == nil ? "" : str!
    }

    func split(split: String) -> Array<String> {
        var array: Array<String> = []
        let range = self.rangeOfString(split, options: .CaseInsensitiveSearch, range: nil, locale: nil)

        if range == nil || range!.isEmpty {
            array.append(self)
        } else {
            array.append(substringWithRange(Range<String.Index>(start: startIndex, end: range!.startIndex)))
            let lastRange = Range<String.Index>(start: range!.endIndex, end: endIndex)
            if !lastRange.isEmpty {
                var subArray = substringWithRange(lastRange).split(split)
                array.addObjects(subArray)
            }
        }

        return array
    }

    func subString(location: Int, length: Int) -> String {
        return (self as NSString).substringWithRange(NSRange(location: location, length: length))
    }

    public func replaceAll(regex: String, replacement: String) -> String {
        let oRegex = NSRegularExpression(pattern: regex, options: .allZeros, error: nil)
        if var regex = oRegex {
            return regex.match(self).replaceAll(replacement)
        }
        return regex
    }
}