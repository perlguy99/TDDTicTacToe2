//
//  TTTBoard.ViewModelTests.swift
//  TDDTicTacToe2Tests
//
//  Created by Brent Michalski on 1/4/23.
//

import XCTest
@testable import TDDTicTacToe2

final class TTTBoardViewModelTests: XCTestCase {

    // TDD 8
    func testBoardContainsNineBoxes() throws {
        let boardViewModel = TTTBoard.ViewModel()
        XCTAssertEqual(boardViewModel.gameBoard.count, 9)
    }
    
    // TDD 9
    func testThatBoardIsCreatedWithItBeingUserXsTurn() throws {
        let boardViewModel = TTTBoard.ViewModel()
        XCTAssertEqual(boardViewModel.turn, TDDTicTacToe2App.Turn.x)
    }
    
    // TDD 10
    func testThatBoardAlternatesTurnsEachTimeABoxIsTapped() throws {
        let boardViewModel = TTTBoard.ViewModel()
        XCTAssertEqual(boardViewModel.turn, TDDTicTacToe2App.Turn.x)
        
        boardViewModel.gameBoard[0].boxTapped()
        XCTAssertEqual(boardViewModel.turn, TDDTicTacToe2App.Turn.o)
    }

}
