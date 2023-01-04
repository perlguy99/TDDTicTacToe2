//
//  TTTBoard.ViewModelTests.swift
//  TDDTicTacToe2Tests
//
//  Created by Brent Michalski on 1/4/23.
//

import XCTest
import Combine
//import ViewInspector
@testable import TDDTicTacToe2

extension TTTBoard.ViewModel: AutomaticallyEquatable { }

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
    
    // TDD 15
    // There is no way to reset the game once all of the boxes have a value
    func testResetBoardToAllEmpty() throws {
        let boardViewModel = TTTBoard.ViewModel()
        boardViewModel.gameBoard = boardViewModel.createGameBoard()

        boardViewModel.gameBoard?[0].boxTapped()
        XCTAssertEqual(boardViewModel.gameBoard?[0].value, .x)

        boardViewModel.gameBoard?[1].boxTapped()
        XCTAssertEqual(boardViewModel.gameBoard?[1].value, .o)

        // Reset the board
        boardViewModel.resetGameBoard()
        XCTAssertEqual(boardViewModel.gameBoard?[0].value, .empty)
        XCTAssertEqual(boardViewModel.gameBoard?[1].value, .empty)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    // TDD 16
    // So, test 15 above proves that everything seems to work in the ViewModels
    // But the BoardView is NOT getting updated right now, so I am going to attempt to
    // check it's published values
    func testViewModelPublishers() throws {
//        let expectation1 = XCTestExpectation(description: "Expectation 1")
//        let expectation2 = XCTestExpectation(description: "Expectation 2")
//        let expectation3 = XCTestExpectation(description: "Expectation 3")
//
//        let boardViewModel = TTTBoard.ViewModel()
        
//        let publisher = boardViewModel.$gameBoard
//
//        /// This error kinda sucks
//        ///Cannot convert value of type '[TTTBox.ViewModel].Type' to expected argument type '(Published<[TTTBox.ViewModel]?>.Publisher.Output) -> Void' (aka '(Optional<Array<TTTBox.ViewModel>>) -> ()')
//
//        publisher.expect([TTTBox.ViewModel])
//            .waitForExpectations(timeout: 1)
        
//        Task {
//            try await Task.sleep(nanoseconds: 500000)
//            boardViewModel.$gameBoard
//                .sink { ttboxViewModel in
//                    XCTAssertEqual(ttboxViewModel?[0].value, .empty)
//                    expectation1.fulfill()
//                }
//                .store(in: &cancellables)
//        }
//
//        wait(for: [expectation1], timeout: 1)
//
//        Task {
//            try await Task.sleep(nanoseconds: 1_000_500_000)
//            boardViewModel.gameBoard?[0].boxTapped()
//        }
//
//        Task {
//            try await Task.sleep(nanoseconds: 3_000_000_000)
//            boardViewModel.gameBoard?[0].boxTapped()
//
//            boardViewModel.$gameBoard
//                .sink { ttboxViewModel in
//                    XCTAssertEqual(ttboxViewModel?[0].value, .x)
//                    expectation2.fulfill()
//                }
//                .store(in: &cancellables)
//        }
//
//        wait(for: [expectation2], timeout: 5)
//
//        Task {
//            try await Task.sleep(nanoseconds: 4_000_500_000)
//            boardViewModel.resetGameBoard()
//        }
//
//        Task {
//            try await Task.sleep(nanoseconds: 6_000_000_000)
//
//            boardViewModel.$gameBoard
//                .sink { ttboxViewModel in
//                    XCTAssertEqual(ttboxViewModel?[0].value, .empty)
//                    expectation3.fulfill()
//                }
//                .store(in: &cancellables)
//        }
//
//        wait(for: [expectation3], timeout: 10)
        
        
        
    }
    
    
    
    // TDD 17
    // Well, testing @StateObjects is kind of a pain
    // Going to try a different approach for a minute
    // Going to load ViewInspector and see how it works for this...
//    func testViewSideEffects() throws {
//        let sut = TTTBoard(viewModel: .init())
//
//        try sut.inspect().findall(TTTBox.self)
//
//        print("\n-------------------------------------")
//        print(sut)
//        print("-------------------------------------\n")
//    }
}
