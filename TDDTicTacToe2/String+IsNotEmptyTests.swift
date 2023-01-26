//
//  String+IsNotEmptyTests.swift
//  TDDTicTacToe2Tests
//
//  Created by Brent Michalski on 1/12/23.
//
@testable import TDDTicTacToe2
import XCTest

final class String_IsNotEmptyTests: XCTestCase {

    func testStringNotEmpty_Various_Cases() throws {
        let string1 = "String 1"
        let string2 = ""
        let string3 = " "
        
        XCTAssertTrue(string1.isNotEmpty)
        XCTAssertFalse(string2.isNotEmpty)
        XCTAssertTrue(string3.isNotEmpty)
    }

}
