//
//  TTTBoard.ViewModelTests.swift
//  TDDTicTacToe2Tests
//
//  Created by Brent Michalski on 1/4/23.
//

import XCTest
import Combine
import ViewInspector
import SwiftUI
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
//    func testViewModelPublishers() throws {
//        let expectation1 = XCTestExpectation(description: "Expectation 1")
//        let expectation2 = XCTestExpectation(description: "Expectation 2")
//        let expectation3 = XCTestExpectation(description: "Expectation 3")
//
//        let boardViewModel = TTTBoard.ViewModel()
//
//        let publisher = boardViewModel.$gameBoard
//
//        /// This error kinda sucks
//        ///Cannot convert value of type '[TTTBox.ViewModel].Type' to expected argument type '(Published<[TTTBox.ViewModel]?>.Publisher.Output) -> Void' (aka '(Optional<Array<TTTBox.ViewModel>>) -> ()')
//
//        publisher.expect([TTTBox.ViewModel])
//            .waitForExpectations(timeout: 1)
//
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
//
//
//
//    }
    
    // TDD 17
    // Well, testing @StateObjects is kind of a pain
    // Going to try a different approach for a minute
    // Going to load ViewInspector and see how it works for this...
    
    /// TDD 17.5
    /// So, what I am experiencing here is that the ViewModels appear to be working properly
    /// however, the values are not updating properly when using them in SwiftUI
    /// So... We need to test that these are being properly broadcast and updated when
    /// using them in SwiftUI.
    /// Step 1: Try to set things up using ViewInspector
    ///

       // Go to TDD 18 instead of here.
//    func testViewSideEffects() throws {
//        let sut = TTTBoard(viewModel: .init())
//
//        try sut.inspect().findall(TTTBox.self)
//
//        print("\n-------------------------------------")
//        print(sut)
//        print("-------------------------------------\n")
//    }
    
    /// TDD 18
    /// Going to try to use the ViewInspector examples to try these tests...
    ///

    // So, these just interact with the ViewModel
    func testViewSideEffects_RenameMe() throws {
        let tttBoardView = TTTBoard(viewModel: .init())

        let expectation = tttBoardView.inspection.inspect { view in

            XCTAssertEqual(try view.actualView().viewModel.gameBoard?[0].value, .empty)
            try view.actualView().viewModel.gameBoard?[0].boxTapped()
            XCTAssertEqual(try view.actualView().viewModel.gameBoard?[0].value, .x)

            // Try to reset the board
            try view.actualView().viewModel.resetGameBoard()
            XCTAssertEqual(try view.actualView().viewModel.gameBoard?[0].value, .empty)
        }

        ViewHosting.host(view: tttBoardView)
        wait(for: [expectation], timeout: 0.5)
    }
        
    // Lets try to just use the View stuff
    /// TDD 19
    /// ViewInspector is not cooperating, moving through a Kodeco ViewInspector tutorial...
    ///
    func testViewSideEffects_UsingViewObjects() throws {
        let tttBoardView = TTTBoard(viewModel: .init())

        let expectation = tttBoardView.inspection.inspect { view in

            XCTAssertEqual(try view.actualView().viewModel.gameBoard?[0].value, .empty)
            
            // Check the first item on the board
            let foo = view.findAll(TTTBox.self)

            // Tap
            try foo[0].actualView().onTapGesture()

            // X?
            XCTAssertEqual(try view.actualView().viewModel.gameBoard?[0].value, .x)

            // Reset the board
            try view.find(button: "Reset Board").tap()

            // Now verify that the first item is empty again
            XCTAssertEqual(try view.actualView().viewModel.gameBoard?[0].value, .empty)
        }

        ViewHosting.host(view: tttBoardView)
        wait(for: [expectation], timeout: 1)
    }

    // TDD 20
    // This is kind of a conundrum... I need to find a way to make sure that the views are getting updated.
    //
    // Played around with the code a little more and found a way to make this part work!
    
    // TDD 18.25
//    func testViewInspectorTestButtonTogglesFlag() throws {
//        let sut = ViewInspectorTest()
//        let exp = sut.inspection.inspect { view in
//            XCTAssertFalse(try view.actualView().flag)
//            try view.button().tap()
//            XCTAssertTrue(try view.actualView().flag)
//        }
//        ViewHosting.host(view: sut)
//        wait(for: [exp], timeout: 0.2)
//    }
    
    // TDD 21
    // We now need a way to determine if someone won the game...
    // To do so, we'll need to setup some known layouts to test against
    func createGameBoard(
        state0: TTTBox.State = .empty,
        state1: TTTBox.State = .empty,
        state2: TTTBox.State = .empty,
        state3: TTTBox.State = .empty,
        state4: TTTBox.State = .empty,
        state5: TTTBox.State = .empty,
        state6: TTTBox.State = .empty,
        state7: TTTBox.State = .empty,
        state8: TTTBox.State = .empty
    ) -> [TTTBox.ViewModel] {
        let tttBoard = TTTBoard.ViewModel()
        return [
            TTTBox.ViewModel(value: state0, turnUpdateDelegate: tttBoard),
            TTTBox.ViewModel(value: state1, turnUpdateDelegate: tttBoard),
            TTTBox.ViewModel(value: state2, turnUpdateDelegate: tttBoard),
            TTTBox.ViewModel(value: state3, turnUpdateDelegate: tttBoard),
            TTTBox.ViewModel(value: state4, turnUpdateDelegate: tttBoard),
            TTTBox.ViewModel(value: state5, turnUpdateDelegate: tttBoard),
            TTTBox.ViewModel(value: state6, turnUpdateDelegate: tttBoard),
            TTTBox.ViewModel(value: state7, turnUpdateDelegate: tttBoard),
            TTTBox.ViewModel(value: state8, turnUpdateDelegate: tttBoard)
        ]
    }
    
    func testIsWinner_WinningCombo_X_Horizontal_Expect_True() throws {
        let tttBoardView = TTTBoard(viewModel: .init())
        
        let board = createGameBoard(state0: .x, state1: .x, state2: .x)
        XCTAssertEqual(tttBoardView.viewModel.isWinner(board: board), "X")
    }

    func testIsWinner_No_WinningCombo_Expect_False() throws {
        let tttBoardView = TTTBoard(viewModel: .init())
        
        let board = createGameBoard(state0: .x, state1: .x)
        XCTAssertEqual(tttBoardView.viewModel.isWinner(board: board), "")
    }
    
    func testIsWinner_WinningCombo_O_Horizontal_Expect_True() throws {
        let board = createGameBoard(state0: .o, state1: .o, state2: .o)
        let tttBoardView = TTTBoard(viewModel: .init(gameBoard: board))
        XCTAssertEqual(tttBoardView.viewModel.isWinner(board: board), "O")
    }

    func testIsWinner_WinningCombo_X_Vertical_Expect_True() throws {
        let tttBoardView = TTTBoard(viewModel: .init())
        
        let board = createGameBoard(state1: .x, state4: .x, state7: .x)
        XCTAssertEqual(tttBoardView.viewModel.isWinner(board: board), "X")
    }

    func testIsWinner_WinningCombo_O_Vertical_Expect_True() throws {
        let tttBoardView = TTTBoard(viewModel: .init())
        
        let board = createGameBoard(state1: .o, state4: .o, state7: .o)
        XCTAssertEqual(tttBoardView.viewModel.isWinner(board: board), "O")
    }

    func testIsWinner_WinningCombo_X_Diagonal1_Expect_True() throws {
        let tttBoardView = TTTBoard(viewModel: .init())
        
        let board = createGameBoard(state0: .x, state4: .x, state8: .x)
        XCTAssertEqual(tttBoardView.viewModel.isWinner(board: board), "X")
    }

    func testIsWinner_WinningCombo_X_Diagonal2_Expect_True() throws {
        let tttBoardView = TTTBoard(viewModel: .init())
        
        let board = createGameBoard(state2: .x, state4: .x, state6: .x)
        XCTAssertEqual(tttBoardView.viewModel.isWinner(board: board), "X")
    }

    func testIsWinner_WinningCombo_O_Diagonal1_Expect_True() throws {
        let tttBoardView = TTTBoard(viewModel: .init())
        
        let board = createGameBoard(state0: .o, state4: .o, state8: .o)
        XCTAssertEqual(tttBoardView.viewModel.isWinner(board: board), "O")
    }

    func testIsWinner_WinningCombo_O_Diagonal2_Expect_True() throws {
        let tttBoardView = TTTBoard(viewModel: .init())

        // This would test just that the ViewModel can see that it is a winner
//        let board = createGameBoard(state2: .o, state4: .o, state6: .o)
//        XCTAssertEqual(tttBoardView.viewModel.isWinner(board: board), "O")

        // This actually acts as a user tapping on the device
        let expectation = tttBoardView.inspection.inspect { view in
            XCTAssertEqual(try view.actualView().viewModel.gameBoard?[0].value, .empty)
            try view.actualView().viewModel.gameBoard?[0].boxTapped() // X
            try view.actualView().viewModel.gameBoard?[2].boxTapped() // O
            try view.actualView().viewModel.gameBoard?[5].boxTapped() // X
            try view.actualView().viewModel.gameBoard?[4].boxTapped() // O
            try view.actualView().viewModel.gameBoard?[3].boxTapped() // X
            try view.actualView().viewModel.gameBoard?[6].boxTapped() // O

            XCTAssertEqual(try view.actualView().viewModel.isWinner(), "O")
        }

        ViewHosting.host(view: tttBoardView)
        wait(for: [expectation], timeout: 1.0)
    }

    // TDD 22
    // Ok, got a BUNCH of tests to see who won.
    // The code to do the checking is terrible, but it made the tests pass
    // Now, to refactor - and keep all checks passing!
    // I did a little refactoring, it is still not very pretty, but it does the job
    // for now...
    
    // TDD 300
    // So, I totally just wrote a solution before I even attempted a test!
    func testThatAlertToShowGetsPopulatedWhenThereIsAWinner() throws {
        let tttBoardView = TTTBoard(viewModel: .init())

        let expectation = tttBoardView.inspection.inspect { view in
            XCTAssertEqual(try view.actualView().viewModel.gameBoard?[0].value, .empty)

            try view.actualView().viewModel.gameBoard?[0].boxTapped() // X
            try view.actualView().viewModel.gameBoard?[3].boxTapped() // O
            try view.actualView().viewModel.gameBoard?[1].boxTapped() // X
            try view.actualView().viewModel.gameBoard?[4].boxTapped() // O
            try view.actualView().viewModel.gameBoard?[2].boxTapped() // X

            if let theTitle = try view.actualView().viewModel.alertToShow?.title {
                XCTAssertEqual(theTitle, "X WINS!")
            }
        }

        ViewHosting.host(view: tttBoardView)
        wait(for: [expectation], timeout: 1.0)
    }
    
    // #TDD 400: - What if it is a tie?
    // #TDD 401: THIS is the way to test items that are in a view
    // BRENT
    // Important: next 2 tests
    func testThatTieGameIsTrueWhenAllBoxesAreFullAndThereIsNoWinner_WITH_VIEW() throws {
        // Set the board up so that it is a tie game
        let tttBoardView = TTTBoard(viewModel: .init(gameBoard: self.createGameBoard(state0: .x, state1: .o, state2: .x, state3: .x, state4: .o, state5: .x, state6: .o, state7: .x, state8: .o)))

        let expectation = tttBoardView.inspection.inspect { view in

            XCTAssertTrue(try view.actualView().viewModel.isTie(board: view.actualView().viewModel.gameBoard!))
        }

        ViewHosting.host(view: tttBoardView)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testThatTieGameIsTrueWhenAllBoxesAreFullAndThereIsNoWinner_WITHOUT_VIEW_SHOWS_WARNING() throws {
        /// So, trying to run your tests this way results in the following warning...
        /// `Accessing StateObject's object without being installed on a View. This will create a new instance each time.`
        /// This tells me that _any_ tests that are changing and checking state won't actually work the same
        /// as they do in the View.
        ///
        
        // Set the board up so that it is a tie game
        let board = createGameBoard(state0: .x, state1: .o, state2: .x, state3: .x, state4: .o, state5: .x, state6: .o, state7: .x, state8: .o)
        let tttBoardView = TTTBoard(viewModel: .init(gameBoard: board))

        XCTAssertTrue(tttBoardView.viewModel.isTie(board: board))
    }
    // BRENT
    
    func testThatTurnDoesNotShowWhenAlertIsShowing_When_X_Wins() throws {
        let text_x = "X's Turn"
        let text_o = "O's Turn"

        let tttBoardView = TTTBoard(viewModel: .init())

        let expectation = tttBoardView.inspection.inspect { view in

            XCTAssertEqual(try view.actualView().viewModel.gameBoard?[0].value, .empty)
            try view.actualView().viewModel.gameBoard?[5].boxTapped() // X
            try view.actualView().viewModel.gameBoard?[0].boxTapped() // O
            try view.actualView().viewModel.gameBoard?[6].boxTapped() // X
            try view.actualView().viewModel.gameBoard?[1].boxTapped() // O
            try view.actualView().viewModel.gameBoard?[3].boxTapped() // X
            try view.actualView().viewModel.gameBoard?[2].boxTapped() // O

            if let theTitle = try view.actualView().viewModel.alertToShow?.title {
                XCTAssertEqual(theTitle, "O WINS!")
            }

            XCTAssertEqual(try view.actualView().viewModel.turnText, "")

            let theText1 = try? view.find(text: text_x)
            let theText2 = try? view.find(text: text_o)
            XCTAssertNil(theText1)
            XCTAssertNil(theText2)
        }

        ViewHosting.host(view: tttBoardView)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testThatTurnDoesNotShowWhenAlertIsShowing_When_O_Wins() throws {
        let text_x = "X's Turn"
        let text_o = "O's Turn"

        let tttBoardView = TTTBoard(viewModel: .init())

        let expectation = tttBoardView.inspection.inspect { view in

            XCTAssertEqual(try view.actualView().viewModel.gameBoard?[0].value, .empty)
            try view.actualView().viewModel.gameBoard?[0].boxTapped() // X
            try view.actualView().viewModel.gameBoard?[3].boxTapped() // O
            try view.actualView().viewModel.gameBoard?[1].boxTapped() // X
            try view.actualView().viewModel.gameBoard?[4].boxTapped() // O
            try view.actualView().viewModel.gameBoard?[2].boxTapped() // X

            if let theTitle = try view.actualView().viewModel.alertToShow?.title {
                XCTAssertEqual(theTitle, "X WINS!")
            }

            XCTAssertEqual(try view.actualView().viewModel.turnText, "")

            let theText1 = try? view.find(text: text_x)
            let theText2 = try? view.find(text: text_o)
            XCTAssertNil(theText1)
            XCTAssertNil(theText2)
        }

        ViewHosting.host(view: tttBoardView)
        wait(for: [expectation], timeout: 2.0)
    }

    
    
    func testThatTieGameIsFalseWhenAllBoxesAreNotFull() throws {
        let tttBoardView = TTTBoard(viewModel: .init())
        
        // Set the board up so that it is a tie game
        let board = createGameBoard(state0: .x, state1: .o, state2: .x, state3: .x, state4: .o, state5: .x, state6: .o, state7: .x)
        
        XCTAssertFalse(tttBoardView.viewModel.isTie(board: board))
    }
    

}
