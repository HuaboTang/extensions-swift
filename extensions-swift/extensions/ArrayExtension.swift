//
//  PKArray.swift
//  PiKey
//
//  Created by 唐华嶓 on 11/24/14.
//  Copyright (c) 2014 piKey. All rights reserved.
//

import Foundation

extension Array {

    mutating func removeObject<U: Equatable>(object: U) {
        var index: Int? = indexOf(object)

        if index != nil {
            removeAtIndex(index!)
        }
    }

    /**
        Remove object which the result of compare with the `compare` is `true`
    
        :param: compare a function to compare each item in this Array
        :returns: a array made by removed items
    */
    mutating func removeObject(compare:(T)->Bool) -> Array {
        var result: Array<T> = []

        var indexs: Array<Int> = []
        for (idx, item) in enumerate(self) {
            if compare(item) {
                indexs.insert(idx, atIndex: 0) //insert at first
            }
        }

        //remove from end to first
        for idx in indexs {
            result.insert(removeAtIndex(idx), atIndex: 0)
        }

        return result
    }

    /// Insert object to this sorted array with Binary insertion
    ///
    /// :param: object the object to be insert to this array
    /// :param: comparator compare function, while compare with a item in array, insert after this item if return 'OrderedAscending',
    ///         insert before this item if return 'OrderedDescending'
    /// :param: insertWhenSame whether insert into this array if compare with a item and return OrderedSame,
    ///         if true will insert after this item.
    /// :returns: return true if the object inserted, else return false
    mutating func bisectionInsertObject(object: T, comparator cmptr: (T, T)->NSComparisonResult, insertWhenSame insert: Bool) -> Bool {
        if count == 0 {
            self.append(object)
            return true
        } else {
            var low = 0
            var high = self.count - 1
            while (low <= high) {
                var mid = (low + high)/2

                let result = cmptr(object, self[mid])
                switch (result) {
                case .OrderedSame:
                    if (insert) {
                        self.insert(object, atIndex: mid+1)
                    }
                    return insert;
                case .OrderedAscending:
                    /* 往后 */
                    low = mid + 1
                    if (low > high) {
                        self.insert(object, atIndex:mid+1)
                        return true
                    }
                case .OrderedDescending:
                    /* 往前 */
                    high = mid - 1
                    if (low > high) {
                        self.insert(object, atIndex:mid)
                        return true
                    }

                }
            }
        }
        assert(false)
        return false
    }

    /// Append all items in array one by one
    mutating func addObjects(array: Array<T>?) {
        if array != nil {
            for item in array! {
                self.append(item)
            }
        }
    }

    mutating func sortedArrayUsingComparator(comp: (obj1: T, obj2: T)-> NSComparisonResult) {
        self.sort { (t1, t2) -> Bool in
            return comp(obj1: t1, obj2: t2) == .OrderedAscending
        }
    }

    func joinWithSplit(split: String) -> String {
        if self.count > 0 {
            var string: String = String()
            for item in self {
                string = string.isEmpty ? "\(item)" : string+"\(split)\(item)"
            }
            return string
        } else {
            return ""
        }
    }

    /// Return object at index in array safely
    func objectAtIndex(index: Int) -> T? {
        return self.count > index ? self[index] : nil
    }

    /// Return the index of the first occurrence of the specified element in this array, 
    /// or nil if this array not contain the element.
    ///
    /// :param:     obj element to search for
    /// :returns:   the index of the first occurrence of the specified element in this array,
    ///             or nil if this array not contain the element
    func indexOf<U: Equatable>(obj: U) -> Int? {
        var index: Int? = nil
        for (idx, objectToCompare) in enumerate(self) {
            if let to = objectToCompare as? U {
                if obj == to {
                    index = idx
                    break
                }
            }
        }

        return index
    }

    /// Return the index of the first occurrence of the specified element 
    /// which invoke 'compare' returns true in this array, or nil if there is no element matched
    ///
    /// :param:     compare a function for compare element
    /// :returns:   Return the index of the first occurrence of the specified element
    ///             which invoke 'compare' returns true in this array, or nil if there is no element matched
    func indexOf(compare: (T) -> Bool) -> Int? {
        for (idx, objectToCompare) in enumerate(self) {
            if compare(objectToCompare) {
                return idx
            }
        }
        return nil
    }

    ///
    func each(handler: (T) -> Bool?) {
        for t in self {
            let r = handler(t)
            if r != nil && !r! {
                break
            }
        }
    }

    mutating func insertObjects(array: Array<T>, atIndex index: Int) {
        if index < self.count && array.count > 0 {
            for i in 0...array.count-1 {
                self.insert(array[i], atIndex: i)
            }
        }
    }
}