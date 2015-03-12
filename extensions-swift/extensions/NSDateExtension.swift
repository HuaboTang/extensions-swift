//
//  NSDateExtension.swift
//  UWifi
//
//  Created by 唐华嶓 on 1/7/15.
//  Copyright (c) 2015 piKey. All rights reserved.
//

import Foundation

let YMD = "yyyy-MM-dd"
let YMDHMS = "yyyy-MM-dd HH:mm:ss"
private let ymdReg = NSRegularExpression(pattern: "[0-9]{4}-[0-9]{2}-[0-9]{2}", options:.DotMatchesLineSeparators, error: nil)

private let ymdhmsReg = NSRegularExpression(pattern: "[0-9]{4}-[0-9]{2}-[0-9]{2}\\s+[0-9]{2}:[0-9]{2}:[0-9]{2}", options: .DotMatchesLineSeparators, error: nil)

private let matchOptions = NSMatchingOptions.WithTransparentBounds

let  componentFlags = (NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.WeekCalendarUnit |  NSCalendarUnit.HourCalendarUnit | NSCalendarUnit.MinuteCalendarUnit | NSCalendarUnit.SecondCalendarUnit | NSCalendarUnit.WeekdayCalendarUnit | NSCalendarUnit.WeekdayOrdinalCalendarUnit)

let D_MINUTE: NSTimeInterval = 60
let D_WEEK: NSTimeInterval = 604800

extension NSDate {

    class func currentCalendar() -> NSCalendar {
        struct tmp {
            static var sharedCalendar: NSCalendar?
        }
        if tmp.sharedCalendar == nil {
            tmp.sharedCalendar = NSCalendar.autoupdatingCurrentCalendar()
        }
        return tmp.sharedCalendar!
    }

    func formatedString(formatExp: String = YMD) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = formatExp
        return formatter.stringFromDate(self)
    }

    class func dateFromString(string: String, dateFormat: String? = nil) -> NSDate? {
        if !string.isEmpty {
            let mString = NSMutableString(string: string)
            let sRange = NSMakeRange(0, mString.length)

            let formatter = NSDateFormatter()

            if dateFormat != nil {
                formatter.dateFormat = dateFormat!
                return formatter.dateFromString(string)
            } else if ymdhmsReg!.numberOfMatchesInString(string, options: matchOptions, range:sRange) > 0 {
                let range = ymdhmsReg!.rangeOfFirstMatchInString(string, options:matchOptions, range:sRange)
                let dateStr = (string as NSString).substringWithRange(range)
                formatter.dateFormat = YMDHMS
                return formatter.dateFromString(dateStr)
            } else if ymdReg!.numberOfMatchesInString(string, options: matchOptions, range:sRange) > 0 {
                let range = ymdReg!.rangeOfFirstMatchInString(string, options: matchOptions, range:sRange)
                let dateStr = (string as NSString).substringWithRange(range)
                formatter.dateFormat = YMD
                return formatter.dateFromString(dateStr)
            }
        }
        return nil
    }

    func isThisHour() -> Bool {
        let cur = NSDate()
        return self.isEqualToDateIgnoringTime(cur) && cur.hour() == self.hour()
    }

    func isToday() -> Bool {
        let cur = NSDate()
        return self.isEqualToDateIgnoringTime(cur)
    }

    /// return true if this date is yesterday
    ///
    /// :returns: return true is this date is yesterday, else return false
    func isYesterday() -> Bool {
        let components1 = NSDate.currentCalendar().components(componentFlags, fromDate: self)
        let components2 = NSDate.currentCalendar().components(componentFlags, fromDate: NSDate())
        return components1.year == components2.year && components1.month == components2.month
            && (components2.day - components1.day) == 1
    }

    func isSameMinutes(date: NSDate) -> Bool {
        let components1 = NSDate.currentCalendar().components(componentFlags, fromDate: self)
        let components2 = NSDate.currentCalendar().components(componentFlags, fromDate: date)
        return components1.year == components2.year && components1.month == components2.month
            && components1.day == components2.day && components1.hour == components2.hour
            && components1.minute == components2.minute
    }

    func isThisWeek() -> Bool {
        let aDate = NSDate()
        let components1 = NSDate.currentCalendar().components(componentFlags, fromDate: self)
        let components2 = NSDate.currentCalendar().components(componentFlags, fromDate: aDate)

        // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
        if components1.weekOfYear != components2.weekOfYear {
            return false
        }

        // Must have a time interval under 1 week.
        return abs(self.timeIntervalSinceDate(aDate)) < D_WEEK
    }

    func minutesOffset(date: NSDate) -> Int {
        let ti = self.timeIntervalSinceDate(date)
        return Int(abs(ti) / D_MINUTE)
    }

    func formatedWeek() -> String {
        switch week() {
        case 1:
            return "星期天"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            return ""
        }
    }

    func simpleFormatedWeeak() -> String {
        switch week() {
        case 1:
            return "周日"
        case 2:
            return "周一"
        case 3:
            return "周二"
        case 4:
            return "周三"
        case 5:
            return "周四"
        case 6:
            return "周五"
        case 7:
            return "周六"
        default:
            return ""
        }
    }

    func isThisYear() -> Bool {
        let aDate = NSDate()
        let components1 = NSDate.currentCalendar().components(componentFlags, fromDate: self)
        let components2 = NSDate.currentCalendar().components(componentFlags, fromDate: aDate)

        return components1.year == components2.year
    }

    func isEqualToDateIgnoringTime(date: NSDate) -> Bool {
        let components1 = NSDate.currentCalendar().components(componentFlags, fromDate: self)
        let components2 = NSDate.currentCalendar().components(componentFlags, fromDate: date)
        return components1.year == components2.year && components1.month == components2.month
            && components1.day == components2.day
    }

    func hour() -> Int {
        let component = NSDate.currentCalendar().components(componentFlags, fromDate: self)
        return component.hour
    }

    func week() -> Int {
        let component = NSDate.currentCalendar().components(componentFlags, fromDate: self)
        return component.weekday
    }
}