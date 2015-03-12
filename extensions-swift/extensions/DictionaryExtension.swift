//
//  DictionaryExtension.swift
//  UWifi
//
//  Created by 唐华嶓 on 12/31/14.
//  Copyright (c) 2014 piKey. All rights reserved.
//

import Foundation

/// Extensions for Dictionary
extension Dictionary {

    /// Return true if the dictionary contains a mapping for the specified key.
    ///
    /// :param: key whose presence in this dictionary is to be tested
    /// :returns: true if this dictionary contains a mapping for the specified key
    func containsKey(key: Key) -> Bool {
        return self[key] != nil
    }
}