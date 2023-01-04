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
        boardViewModel.gameBoard = boardViewModel.createGameBoard()
        XCTAssertEqual(boardViewModel.gameBoard?.count, 9)
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
        
        boardViewModel.boxTapped()
        XCTAssertEqual(boardViewModel.turn, TDDTicTacToe2App.Turn.o)
        
        boardViewModel.boxTapped()
        XCTAssertEqual(boardViewModel.turn, TDDTicTacToe2App.Turn.x)
        
        boardViewModel.boxTapped()
        XCTAssertEqual(boardViewModel.turn, TDDTicTacToe2App.Turn.o)
    }
    
    // TDD 11 - Getting kinda at a place where I feel I need to go in many directions,
    // trying to reign it all in.
    func testCreateGameBoardMethodReturnsNineBoxes() throws {
        let foo = TTTBoard.ViewModel().createGameBoard()
        XCTAssertEqual(foo.count, 9)
    }
    
    // TDD 12
    // I did a bit of refactoring, all tests still green
    // This is where my brain wanted to go next...
    func testTapBoxButtonUpdatesTurn_And_UpdatesBoxValue() throws {
        let boardViewModel = TTTBoard.ViewModel()
        boardViewModel.gameBoard = boardViewModel.createGameBoard()
        
        XCTAssertEqual(boardViewModel.turn, TDDTicTacToe2App.Turn.x)
        
        guard let gameBoard = boardViewModel.gameBoard else {
            XCTFail("Expected to find a game board!")
            return
        }
        
        // Verify 1st item is empty
        XCTAssertEqual(gameBoard[0].value, .empty)
        XCTAssertEqual(boardViewModel.turn, .x)
        
        // Perform the action
        gameBoard[0].boxTapped()
        
        // Verify the actions
        XCTAssertEqual(gameBoard[0].value, .x)
        XCTAssertEqual(boardViewModel.turn, .o)
    }
    
    // TDD 12.5
    // So, the current test failure is that when a box is tapped, the board doesn't change the turn
    //

    // TDD 13
    /// Now, when running the app, when you tap on a box, the text for current user does not get updated.
    /// For this one, we need to make some Combine/SwiftUI changes in the View (`TTTBoard.swift`) and
    /// ViewModel (`TTTBoardViewModel.swift`)
    /// Heading there now...
    /// Changing `var viewModel: ViewModel` to `@StateObject var viewModel: ViewModel`
    /// Causes this error: `Generic struct 'StateObject' requires that 'TTTBoard.ViewModel' conform to 'ObservableObject'`
    /// Need to fix this...
    /// 
    
}
