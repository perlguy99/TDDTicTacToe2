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
        var turnUpdateDelegate: TurnUpdatable?
        
        var turn: TDDTicTacToe2App.Turn? {
            return turnUpdateDelegate?.currentTurn
        }
        
        init(value: TTTBox.State = .empty, turnUpdateDelegate: TurnUpdatable? = nil) {
            self.value = value
            
            if let turnUpdateDelegate = turnUpdateDelegate {
                self.turnUpdateDelegate = turnUpdateDelegate
            }
        }
        
        func boxTapped() {
            switch turn {
                case .x:
                    value = .x
                case .o:
                    value = .o
                case .none:
                    value = .x
            }
            
            if let turnUpdateDelegate = turnUpdateDelegate {
                turnUpdateDelegate.updateTurn()
            }
        }
        
    }
    
    enum State: String {
        case empty = "-"
        case x = "X"
        case o = "O"
    }
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

