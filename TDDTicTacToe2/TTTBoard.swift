//
//  TTTBoard.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/4/23.
//

import SwiftUI

public let TEST_BOX_ID: String = "box0"

struct TTTBoard: View {
    #if DEBUG
    internal let inspection = Inspection<Self>() // 1 of 2 for ViewInspector
    #endif
    @StateObject var viewModel: ViewModel
    
    var body: some View {
    
        VStack {
            Text("TDD Tic-Tac-Toe")
                .font(.largeTitle)
                .padding(.top, 25)
            
            Spacer()
            
            Text(viewModel.turnText)
                .font(.title)
                .padding(.bottom, 60)
            
            if let gameBoard = viewModel.gameBoard {
                HStack {
                    TTTBox(viewModel: gameBoard[0])
                        .id(TEST_BOX_ID)
                        .tag(TEST_BOX_ID)
                    TTTBox(viewModel: gameBoard[1]).tag(1)
                    TTTBox(viewModel: gameBoard[2]).tag(2)
                }
                
                HStack {
                    TTTBox(viewModel: gameBoard[3]).tag(3)
                    TTTBox(viewModel: gameBoard[4]).tag(4)
                    TTTBox(viewModel: gameBoard[5]).tag(5)
                }
                
                HStack {
                    TTTBox(viewModel: gameBoard[6]).tag(6)
                    TTTBox(viewModel: gameBoard[7]).tag(7)
                    TTTBox(viewModel: gameBoard[8]).tag(8)
                }
            }
            
            Spacer()
            Button("Reset Board") {
                viewModel.resetGameBoard()
            }
            .accessibilityIdentifier("ResetBoardButton")

        }
        #if DEBUG
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) } // 2 of 2 for ViewInspector
        #endif
        .alert(item: $viewModel.alertToShow) { alertViewModel in
            Alert(
                title: Text(alertViewModel.title),
                message: Text(alertViewModel.message),
                dismissButton: .default(
                    Text(alertViewModel.buttonText),
                    action: alertViewModel.buttonAction
                )
            )
        }
    }
}

struct TTTBoard_Previews: PreviewProvider {
    static let viewModel = TTTBoard.ViewModel()
    
    static var previews: some View {
        TTTBoard(viewModel: viewModel)
    }
}
