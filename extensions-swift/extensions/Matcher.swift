//
//  Matcher.swift
//  UWifi
//
//  Created by 唐华嶓 on 1/26/15.
//  Copyright (c) 2015 piKey. All rights reserved.
//

import UIKit

/// A utility class that performs match operations on a String, like "Matcher" in Java
public class Matcher: NSObject {
    private var regular: NSRegularExpression
    private var beMatchString: String
    private var entireMatches: [NSTextCheckingResult]

    /// Init a match with a Regular Entity and a string
    /// :param: regular the regex pattern
    /// :param: beMatchString to be matched String
    public init(regular: NSRegularExpression, beMatchString: String) {
        self.regular = regular
        self.beMatchString = beMatchString
        entireMatches = self.regular.matchesInString(beMatchString, options: .allZeros,
            range: NSMakeRange(0, beMatchString.length)) as [NSTextCheckingResult]

        super.init()
    }

    /// Attempts to match the entire region against the pattern
    ///
    /// :returns: true if, and only if, the entire region sequence matches this matcher's pattern
    public func matches() -> Bool {
        if entireMatches.count == 1 {
            let first = entireMatches.first!.rangeAtIndex(0)
            return first.location == 0 && first.length == beMatchString.length
        }
        return false
    }

    /// Returns the number of capturing groups in this matcher's pattern.
    /// Group zero denotes the entire pattern by convention. It is included in this count.
    ///
    /// :returns: the number of capturing groups in this matcher's pattern
    public func numberOfGroups() -> Int {
        return NumberUtils.notNullInt(entireMatches.first!.numberOfRanges)
    }

    public func groupRange(group: Int) -> NSRange? {
        return entireMatches.first!.rangeAtIndex(group)
    }

    /// Returns the input subsequence captured by the given group during the previous match operation.
    public func group(group: Int) -> String? {
        if NumberUtils.notNullInt(entireMatches.first!.numberOfRanges) > group {
            let range = entireMatches.first!.rangeAtIndex(group)
            return (beMatchString as NSString).substringWithRange(range)
        } else {
            return nil
        }
    }

    public func replaceAll(replacement: String) -> String {
        var tmp = String(beMatchString) as NSString

        if entireMatches.count > 0 {
            for entireMatche in entireMatches {
                let numberOfRanges = entireMatche.numberOfRanges
                if numberOfRanges > 0 {
                    for var i=numberOfRanges-1; i>=0; i-- {
                        tmp = tmp.stringByReplacingCharactersInRange(entireMatche.rangeAtIndex(i),
                            withString: replacement)
                    }
                }
            }
        }
        return tmp
    }
}