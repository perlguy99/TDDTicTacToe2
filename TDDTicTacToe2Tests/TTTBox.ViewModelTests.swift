//
//  TTTBox.ViewModelTests.swift
//  TDDTicTacToe2Tests
//
//  Created by Brent Michalski on 1/4/23.
//

import XCTest
@testable import TDDTicTacToe2

extension TTTBox.ViewModel: AutomaticallyEquatable { }

final class TTTBoxViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    // - Boxes can be "-", "X", or "O"
    // Upon creation, we want the box to be "empty" or "-" "tttEmptyString"
    // TDD 1
    func testTTTBoxIsEmptyUponCreationWithNoParametersPassed() throws {
        let viewModel = TTTBox.ViewModel()
        XCTAssertEqual(viewModel.value.rawValue, tttEmptyString)
    }

    // TDD 2
    // No longer needed because of TDD 3 below
//    func testTTTBoxIsFilledWithArgumentPassed() throws {
//        let viewModel = TTTBox.ViewModel(value: "Z")
//        XCTAssertEqual(viewModel.value, "Z")
//    }
    
    // TDD 3
//    func testTTTBoxCanOnlyContainProperValues_DefaultsToDash() throws {
//        let good1 = "-"
//        let good2 = "X"
//        let good3 = "O"
//        let bad1  = "A"
//        let bad2  = "Z"
//        let bad3  = ""
//
//        let viewModel1 = TTTBox.ViewModel(value: good1)
//        XCTAssertEqual(viewModel1.value.rawValue, good1)
//
//        let viewModel2 = TTTBox.ViewModel(value: good2)
//        XCTAssertEqual(viewModel2.value.rawValue, good2)
//
//        let viewModel3 = TTTBox.ViewModel(value: good3)
//        XCTAssertEqual(viewModel3.value.rawValue, good3)
//
//        let viewModel4 = TTTBox.ViewModel(value: bad1)
//        XCTAssertEqual(viewModel4.value.rawValue, good1)
//
//        let viewModel5 = TTTBox.ViewModel(value: bad2)
//        XCTAssertEqual(viewModel5.value.rawValue, good1)
//
//        let viewModel6 = TTTBox.ViewModel(value: bad3)
//        XCTAssertEqual(viewModel6.value.rawValue, good1)
//    }

    // TDD 4 (gets rid of TDD 3)
    // Upon refactoring, we should no longer be able to pass an invalid value
    func testTTTBoxCanOnlyContainProperValues_DefaultsToDash() throws {
        let good1 = TTTBox.State.empty
        let good2 = TTTBox.State.x
        let good3 = TTTBox.State.o
        
        let viewModel1 = TTTBox.ViewModel(value: good1)
        XCTAssertEqual(viewModel1.value.rawValue, good1.rawValue)

        let viewModel2 = TTTBox.ViewModel(value: good2)
        XCTAssertEqual(viewModel2.value.rawValue, good2.rawValue)

        let viewModel3 = TTTBox.ViewModel(value: good3)
        XCTAssertEqual(viewModel3.value.rawValue, good3.rawValue)
    }
    
    // TDD 5
    // Check that when a box is tapped, it changes value
    func testThatWhenBoxIsTappedItChangesValue() throws {
        let viewModel = TTTBox.ViewModel()
        let initialValue = viewModel.value
        
        XCTAssertEqual(viewModel.value, initialValue)
        
        viewModel.boxTapped()
        XCTAssertNotEqual(viewModel.value, initialValue)
    }
    
    // TDD 6
    func testThatBoxChangesToX_WhenXsTurn() throws {
        let boardViewModel = TTTBoard.ViewModel(turn: .x)
        let viewModel = TTTBox.ViewModel()
        viewModel.turnUpdateDelegate = boardViewModel

        // Assert that the value is .empty
        XCTAssertEqual(viewModel.value, .empty)
        
        // Ensure that it is X's turn
        XCTAssertEqual(boardViewModel.turn, .x)

        // Tap the box
        viewModel.boxTapped()

        // Assert that the value is .x
        XCTAssertEqual(viewModel.value, .x)
    }
    
    // TDD 7
    func testThatBoxChangesToO_WhenOsTurn() throws {
        let boardViewModel = TTTBoard.ViewModel(turn: .x)
        let viewModel = TTTBox.ViewModel()
        viewModel.turnUpdateDelegate = boardViewModel

        // Assert that the value is .empty
        XCTAssertEqual(viewModel.value, .empty)
        
        // Ensure that it is O's turn
        boardViewModel.turn = .o
        XCTAssertEqual(viewModel.turn, .o)

        // Tap the box
        viewModel.boxTapped()

        // Assert that the value is .o
        XCTAssertEqual(viewModel.value, .o)
    }


    // TDD 13.5ish
    // Need to make Box not track "Turn" anymore and to get it from "Board"
    func testThatBoxChangesToX_WhenBoardSaysItIsXsTurn() throws {
        let boardViewModel = TTTBoard.ViewModel(turn: .x)
        let viewModel = TTTBox.ViewModel()
        viewModel.turnUpdateDelegate = boardViewModel

        // Assert that the value is .empty
        XCTAssertEqual(viewModel.value, .empty)
        
        // Ensure that it is X's turn
        boardViewModel.turn = .x
        XCTAssertEqual(boardViewModel.turn, .x)

        // Tap the box
        viewModel.boxTapped()

        // Assert that the value is .x
        XCTAssertEqual(viewModel.value, .x)
        XCTAssertEqual(boardViewModel.turn, .o)
    }
    
    // TDD 14
    // The value changes between X and O, but if a Box contains a value, it should no
    // longer be able to be changed...
    func testThatValueAndTurnDoNotChangeWhenTappingOnABoxContainingXorO() throws {
        let boardViewModel = TTTBoard.ViewModel(turn: .x)
        let viewModel = TTTBox.ViewModel()
        viewModel.turnUpdateDelegate = boardViewModel

        // Assert that the value is .empty
        XCTAssertEqual(viewModel.value, .empty)
        
        // Ensure that it is X's turn
        boardViewModel.turn = .x
        XCTAssertEqual(boardViewModel.turn, .x)

        // Tap the box
        viewModel.boxTapped()

        // Assert that the value is .x
        XCTAssertEqual(viewModel.value, .x)
        XCTAssertEqual(boardViewModel.turn, .o)

        // Tap the box again
        viewModel.boxTapped()

        // Now, try an tap again and verify that the value doesn't change
        // Nor should the turn change
        XCTAssertEqual(viewModel.value, .x)
        XCTAssertEqual(boardViewModel.turn, .o)
        
        // Tap the box again
        viewModel.boxTapped()

        // Now, try an tap again and verify that the value doesn't change
        // Nor should the turn change
        XCTAssertEqual(viewModel.value, .x)
        XCTAssertEqual(boardViewModel.turn, .o)
    }
    

}

