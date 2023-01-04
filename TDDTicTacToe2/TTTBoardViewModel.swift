//
//  TTTBoardViewModel.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/4/23.
//

import Foundation

extension TTTBoard {
    
    class ViewModel {
        var turn: TDDTicTacToe2App.Turn = .x
        
        var gameBoard: [TTTBox.ViewModel] = [
            TTTBox.ViewModel(),
            TTTBox.ViewModel(),
            TTTBox.ViewModel(),
            TTTBox.ViewModel(),
            TTTBox.ViewModel(),
            TTTBox.ViewModel(),
            TTTBox.ViewModel(),
            TTTBox.ViewModel(),
            TTTBox.ViewModel(),
        ]
        
        func boxTapped() {
            turn = (turn == .x ? .o : .x)
        }
    
        
    }
}
