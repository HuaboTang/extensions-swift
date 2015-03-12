//
//  TimerUtils.swift
//  UWifi
//
//  Created by 唐华嶓 on 1/7/15.
//  Copyright (c) 2015 piKey. All rights reserved.
//

import Foundation

class TimerUtils {
    
    class func doAfter(millisecond: Int, block: dispatch_block_t) {
        let delay = Int64(millisecond) * Int64(NSEC_PER_MSEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, delay)
        dispatch_after(time, dispatch_get_main_queue(), block)
    }
}