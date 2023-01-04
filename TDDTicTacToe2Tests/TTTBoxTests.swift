//
//  TTTBoxTests.swift
//  TDDTicTacToe2Tests
//
//  Created by Brent Michalski on 1/4/23.
//

import XCTest
@testable import TDDTicTacToe2

final class TTTBoxTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    // - Boxes can be "-", "X", or "O"
    // Upon creation, we want the box to be "empty" or "-" "tttEmptyString"
    // TDD 1
    func testTTTBoxIsEmptyUponCreationWithNoParametersPassed() throws {
        let viewModel = TTTBox.ViewModel()
        XCTAssertEqual(viewModel.value, tttEmptyString)
    }

    // TDD 2
    // No longer needed because of TDD 3 below
//    func testTTTBoxIsFilledWithArgumentPassed() throws {
//        let viewModel = TTTBox.ViewModel(value: "Z")
//        XCTAssertEqual(viewModel.value, "Z")
//    }
    
    // TDD 3
    func testTTTBoxCanOnlyContainProperValues_DefaultsToDash() throws {
        let good1 = "-"
        let good2 = "X"
        let good3 = "O"
        let bad1  = "A"
        let bad2  = "Z"
        let bad3  = ""
        
        let viewModel1 = TTTBox.ViewModel(value: good1)
        XCTAssertEqual(viewModel1.value, good1)

        let viewModel2 = TTTBox.ViewModel(value: good2)
        XCTAssertEqual(viewModel2.value, good2)

        let viewModel3 = TTTBox.ViewModel(value: good3)
        XCTAssertEqual(viewModel3.value, good3)

        let viewModel4 = TTTBox.ViewModel(value: bad1)
        XCTAssertEqual(viewModel4.value, good1)

        let viewModel5 = TTTBox.ViewModel(value: bad2)
        XCTAssertEqual(viewModel5.value, good1)

        let viewModel6 = TTTBox.ViewModel(value: bad3)
        XCTAssertEqual(viewModel6.value, good1)
    }


}
