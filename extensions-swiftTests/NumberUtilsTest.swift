//
//  NumberUtils.swift
//  extensions-swift
//
//  Created by 唐华嶓 on 3/12/15.
//  Copyright (c) 2015 HuaboTang. All rights reserved.
//

import UIKit
import XCTest
import extensions_swift

class NumberUtilsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testToInt() {
        XCTAssert(NumberUtils.toInt("") == 0)
        XCTAssert(NumberUtils.toInt("a") == 0)
        XCTAssert(NumberUtils.toInt("1") == 1)
        XCTAssert(NumberUtils.toInt("-1") == -1)
    }

    func testToIntValueDefValue() {
        XCTAssert(NumberUtils.toInt("", defValue: 1) == 1)
        XCTAssert(NumberUtils.toInt("a", defValue: 1) == 1)
        XCTAssert(NumberUtils.toInt("1", defValue: 1) == 1)
        XCTAssert(NumberUtils.toInt("-1", defValue: 1) == -1)
    }

    func testNotNullInt() {
        XCTAssert(NumberUtils.notNullInt(nil) == 0)
        XCTAssert(NumberUtils.notNullInt(1) == 1)
    }

    func testNotNullIntValueDefaultValue() {
        XCTAssert(NumberUtils.notNullInt(nil, defaultValue: 1) == 1)
        XCTAssert(NumberUtils.notNullInt(-1, defaultValue: 1) == -1)
    }
}
