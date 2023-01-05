//
//  TTTBoard.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/4/23.
//

import SwiftUI

struct TTTBoard: View {
    internal let inspection = Inspection<Self>() // 1 of 2 for ViewInspector
    @StateObject var viewModel: ViewModel
    
    var body: some View {
    
        VStack {
            Spacer()
            
            Text("It's \(viewModel.turn.text)'s Turn")

            if let gameBoard = viewModel.gameBoard {
                HStack {
                    TTTBox(viewModel: gameBoard[0])
                    TTTBox(viewModel: gameBoard[1])
                    TTTBox(viewModel: gameBoard[2])
                }
                
                HStack {
                    TTTBox(viewModel: gameBoard[3])
                    TTTBox(viewModel: gameBoard[4])
                    TTTBox(viewModel: gameBoard[5])
                }
                
                HStack {
                    TTTBox(viewModel: gameBoard[6])
                    TTTBox(viewModel: gameBoard[7])
                    TTTBox(viewModel: gameBoard[8])
                }
            }
            
            Spacer()
            Button("Reset Board") {
                viewModel.resetGameBoard()
            }
            .accessibilityIdentifier("ResetBoardButton")

        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) } // 2 of 2 for ViewInspector
    }
}

struct TTTBoard_Previews: PreviewProvider {
    static let viewModel = TTTBoard.ViewModel()
    
    static var previews: some View {
        TTTBoard(viewModel: viewModel)
    }
}
