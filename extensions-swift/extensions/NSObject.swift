//
//  NSObject.swift
//  UWifi
//
//  Created by 唐华嶓 on 12/26/14.
//  Copyright (c) 2014 piKey. All rights reserved.
//

import Foundation


extension NSObject {

    /// Obtains a class by name, this method will crash if compile with Faster[-0](2014-03-11)
    ///
    /// :param: className the name of class
    /// :returns: The class object named by aClassName, or nil if no class by that name is currently loaded.
    class func swiftClassFromString(className: String) -> AnyClass! {
        // get the project name
        var appName = "UWifi"
        // generate the full name of your class (take a look into your "YourProject-swift.h" file)
        let classStringName = "_TtC\(appName.utf16Count)\(appName)\(countElements(className))\(className)"
        // return the class!
        return NSClassFromString(classStringName)
    }
}