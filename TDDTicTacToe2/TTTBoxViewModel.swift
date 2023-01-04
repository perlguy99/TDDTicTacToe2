//
//  TTTBoxViewModel.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/4/23.
//

// Valid values are "-", "X", and "O"
import Foundation
extension TTTBox {
    
    class ViewModel {
        var value = "-"
        
        init(value: String = "-") {
            if value == "-" || value == "X" || value == "O" {
                self.value = value
            } else {
                self.value = "-"
            }
        }
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

