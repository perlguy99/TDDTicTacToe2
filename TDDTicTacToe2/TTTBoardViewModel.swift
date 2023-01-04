//
//  TTTBoardViewModel.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/4/23.
//

import Foundation

extension TDDTicTacToe2App {
    enum Turn {
        case x
        case o
        
        var text: String {
            switch self {
                case .x:
                    return "X"
                case .o:
                    return "O"
            }
        }
    }
}

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
    
        
    }
}
