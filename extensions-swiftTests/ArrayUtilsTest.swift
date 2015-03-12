//
//  ArrayUtilsTest.swift
//  extensions-swift
//
//  Created by 唐华嶓 on 3/12/15.
//  Copyright (c) 2015 HuaboTang. All rights reserved.
//

import UIKit
import XCTest
import extensions_swift

class ArrayUtilsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNotEmpty() {
        var array: Array<AnyObject>? = nil

        XCTAssertTrue(!ArrayUtils.notEmpty(array))

        array = []
        XCTAssertTrue(!ArrayUtils.notEmpty(array))

        array = [1]
        XCTAssertTrue(ArrayUtils.notEmpty(array))
    }

    func testIsEmpty() {
        var array: Array<AnyObject>? = nil

        XCTAssertTrue(ArrayUtils.isEmpty(array))

        array = []
        XCTAssertTrue(ArrayUtils.isEmpty(array))

        array = [1]
        XCTAssertTrue(!ArrayUtils.isEmpty(array))
    }

    /*
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    */

}
