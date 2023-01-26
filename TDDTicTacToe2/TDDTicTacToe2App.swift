//
//  TDDTicTacToe2App.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/4/23.
//

import SwiftUI

@main
struct TDDTicTacToe2App: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            TTTBoard(viewModel: .init())
        }
    }
}

extension TDDTicTacToe2App {
    
    enum Turn {
        case x
        case o
        
        var text: String {
            switch self {
                case .x:
                    return "X's Turn"
                case .o:
                    return "O's Turn"
            }
        }
    }
}
