//
//  TTTBoardViewModel.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/4/23.
//

import Foundation

extension TTTBoard {
    
    class ViewModel: ObservableObject {
        @Published var turn: TDDTicTacToe2App.Turn = .x
        
        var gameBoard: [TTTBox.ViewModel]?

        init(turn: TDDTicTacToe2App.Turn = .x, gameBoard: [TTTBox.ViewModel]? = nil) {
            self.turn = turn
            self.gameBoard = gameBoard
            
            if self.gameBoard == nil {
                self.gameBoard = createGameBoard()
            }
        }
        
        func boxTapped() {
            turn = (turn == .x ? .o : .x)
        }

        func createGameBoard() -> [TTTBox.ViewModel] {
            return [
                TTTBox.ViewModel(turnUpdateDelegate: self),
                TTTBox.ViewModel(turnUpdateDelegate: self),
                TTTBox.ViewModel(turnUpdateDelegate: self),
                TTTBox.ViewModel(turnUpdateDelegate: self),
                TTTBox.ViewModel(turnUpdateDelegate: self),
                TTTBox.ViewModel(turnUpdateDelegate: self),
                TTTBox.ViewModel(turnUpdateDelegate: self),
                TTTBox.ViewModel(turnUpdateDelegate: self),
                TTTBox.ViewModel(turnUpdateDelegate: self),
            ]
        }
    }
}

protocol TurnUpdatable {
    var currentTurn: TDDTicTacToe2App.Turn { get }
    func updateTurn()
}

extension TTTBoard.ViewModel: TurnUpdatable {
    var currentTurn: TDDTicTacToe2App.Turn {
        return turn
    }
    
    func updateTurn() {
        boxTapped()
    }
}
