//
//  TTTBoard.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/4/23.
//

import SwiftUI

struct TTTBoard: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
    
        VStack {
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

        }
        
        
    }
}

struct TTTBoard_Previews: PreviewProvider {
    static let viewModel = TTTBoard.ViewModel()
    
    static var previews: some View {
        TTTBoard(viewModel: viewModel)
    }
}
