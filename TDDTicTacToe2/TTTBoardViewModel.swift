//
//  TTTBoardViewModel.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/4/23.
//

import Foundation
import SwiftUI

extension TTTBoard {
    
    class ViewModel: ObservableObject {
        @Published var turn: TDDTicTacToe2App.Turn = .x
        @Published var gameBoard: [TTTBox.ViewModel]?
        @Published var alertToShow: Alert.ViewModel?
        
        init(turn: TDDTicTacToe2App.Turn = .x, gameBoard: [TTTBox.ViewModel]? = nil) {
            self.turn = turn
            self.gameBoard = gameBoard
            
            if self.gameBoard == nil {
                self.gameBoard = createGameBoard()
            }
        }
        
        func boxTapped() {
            guard let gameBoard = gameBoard else { return }
            
            turn = (turn == .x ? .o : .x)
            let foo = isWinner(board: gameBoard)
            
            if !foo.isEmpty {
                self.alertToShow = Alert.ViewModel(
                    title: "\(foo) WINS!",
                    message: "\(foo) won the game!",
                    buttonText: "Play Again",
                    buttonAction: resetGameBoard
                )
            }
        }

        func resetGameBoard() {
            for idx in 0...8 {
                self.gameBoard?[idx].value = .empty
            }
            turn = .x
        }
        
        func isWinner(board: [TTTBox.ViewModel]) -> String {

            func isThreeInARowHorizontal(board: [TTTBox.ViewModel]) -> String {
                if checkHorizontal(board: board, forState: .x) == "X" {
                    return "X"
                }
                if checkHorizontal(board: board, forState: .o) == "O" {
                    return "O"
                }
                return ""
            }

            func isThreeInARowVertical(board: [TTTBox.ViewModel]) -> String {
                if checkVertical(board: board, forState: .x) == "X" {
                    return "X"
                }
                if checkVertical(board: board, forState: .o) == "O" {
                    return "O"
                }
                return ""
            }
            
            func isThreeInARowDiagonal(board: [TTTBox.ViewModel]) -> String {
                if checkDiagonal(board: board, forState: .x) == "X" {
                    return "X"
                }
                if checkDiagonal(board: board, forState: .o) == "O" {
                    return "O"
                }
                return ""
            }

            // 0, 1, 2  ..  3, 4, 5  ..  6, 7, 8
            func checkHorizontal(board: [TTTBox.ViewModel], forState state: TTTBox.State) -> String {
                if board[0].value == state && board[1].value == state && board[2].value == state { return state.rawValue }
                if board[3].value == state && board[4].value == state && board[5].value == state { return state.rawValue }
                if board[6].value == state && board[7].value == state && board[8].value == state { return state.rawValue }
                return ""
            }

            func checkVertical(board: [TTTBox.ViewModel], forState state: TTTBox.State) -> String {
                if board[0].value == state && board[3].value == state && board[6].value == state { return state.rawValue }
                if board[1].value == state && board[4].value == state && board[7].value == state { return state.rawValue }
                if board[2].value == state && board[5].value == state && board[8].value == state { return state.rawValue }
                return ""
            }

            func checkDiagonal(board: [TTTBox.ViewModel], forState state: TTTBox.State) -> String {
                if board[0].value == state && board[4].value == state && board[8].value == state { return state.rawValue }
                if board[2].value == state && board[4].value == state && board[6].value == state { return state.rawValue }
                return ""
            }
            
            if isThreeInARowHorizontal(board: board) == "X" {
                return "X"
            } else if isThreeInARowHorizontal(board: board) == "O" {
                return "O"
            }

            if isThreeInARowVertical(board: board) == "X" {
                return "X"
            } else if isThreeInARowVertical(board: board) == "O" {
                return "O"
            }

            if isThreeInARowDiagonal(board: board) == "X" {
                return "X"
            } else if isThreeInARowDiagonal(board: board) == "O" {
                return "O"
            }

            return ""
        }
        
        func createGameBoard() -> [TTTBox.ViewModel] {
            return [
                TTTBox.ViewModel(value: .empty, turnUpdateDelegate: self),
                TTTBox.ViewModel(value: .empty, turnUpdateDelegate: self),
                TTTBox.ViewModel(value: .empty, turnUpdateDelegate: self),
                TTTBox.ViewModel(value: .empty, turnUpdateDelegate: self),
                TTTBox.ViewModel(value: .empty, turnUpdateDelegate: self),
                TTTBox.ViewModel(value: .empty, turnUpdateDelegate: self),
                TTTBox.ViewModel(value: .empty, turnUpdateDelegate: self),
                TTTBox.ViewModel(value: .empty, turnUpdateDelegate: self),
                TTTBox.ViewModel(value: .empty, turnUpdateDelegate: self),
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




// For enjoyment only... The original version of 'isWinner'
//func isWinner(board: [TTTBox.ViewModel]) -> String {
//    func isThreeInARowHorizontal(board: [TTTBox.ViewModel]) -> String {
//        if board[0].value == .x && board[1].value == .x && board[2].value == .x { return "X" }
//        if board[0].value == .o && board[1].value == .o && board[2].value == .o { return "O" }
//
//        if board[3].value == .x && board[4].value == .x && board[5].value == .x { return "X" }
//        if board[3].value == .o && board[4].value == .o && board[5].value == .o { return "O" }
//
//        if board[6].value == .x && board[7].value == .x && board[8].value == .x { return "X" }
//        if board[6].value == .o && board[7].value == .o && board[8].value == .o { return "O" }
//
//        return ""
//    }
//
//    func isThreeInARowVertical(board: [TTTBox.ViewModel]) -> String {
//        if board[0].value == .x && board[3].value == .x && board[6].value == .x { return "X" }
//        if board[0].value == .o && board[3].value == .o && board[6].value == .o { return "O" }
//
//        if board[1].value == .x && board[4].value == .x && board[7].value == .x { return "X" }
//        if board[1].value == .o && board[4].value == .o && board[7].value == .o { return "O" }
//
//        if board[2].value == .x && board[5].value == .x && board[8].value == .x { return "X" }
//        if board[2].value == .o && board[5].value == .o && board[8].value == .o { return "O" }
//
//        return ""
//    }
//
//    func isThreeInARowDiagonal(board: [TTTBox.ViewModel]) -> String {
//        if board[0].value == .x && board[4].value == .x && board[8].value == .x { return "X" }
//        if board[0].value == .o && board[4].value == .o && board[8].value == .o { return "O" }
//
//        if board[2].value == .x && board[4].value == .x && board[6].value == .x { return "X" }
//        if board[2].value == .o && board[4].value == .o && board[6].value == .o { return "O" }
//
//        return ""
//    }
//
//    if isThreeInARowHorizontal(board: board) == "X" {
//        return "X"
//    } else if isThreeInARowHorizontal(board: board) == "O" {
//        return "O"
//    }
//
//    if isThreeInARowVertical(board: board) == "X" {
//        return "X"
//    } else if isThreeInARowVertical(board: board) == "O" {
//        return "O"
//    }
//
//    if isThreeInARowDiagonal(board: board) == "X" {
//        return "X"
//    } else if isThreeInARowDiagonal(board: board) == "O" {
//        return "O"
//    }
//
//    return ""
//}
