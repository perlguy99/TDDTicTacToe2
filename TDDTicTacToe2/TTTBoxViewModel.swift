//
//  TTTBoxViewModel.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/4/23.
//

// Valid values are "-", "X", and "O"
import Foundation

extension TTTBox {
    
    class ViewModel: ObservableObject {
        @Published var value: TTTBox.State = .empty
        @Published var turn: TDDTicTacToe2App.Turn = .x
        
        init(value: TTTBox.State = .empty, turn: TDDTicTacToe2App.Turn = .x) {
            self.value = value
            self.turn = turn
        }
        
        func boxTapped() {
            switch turn {
                case .x:
                    value = .x
                case .o:
                    value = .o
            }
        }
    }
    
    enum State: String {
        case empty = "-"
        case x = "X"
        case o = "O"
    }
    
//    enum Turn {
//        case x
//        case o
//    }
    
}


// Started with this, then refactoring
//class ViewModel {
//    var value = "-"
//
//    init(value: String = "-") {
//        if value == "-" || value == "X" || value == "O" {
//            self.value = value
//        } else {
//            self.value = "-"
//        }
//    }
//}

