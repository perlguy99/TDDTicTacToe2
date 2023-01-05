//
//  TTTBox.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/4/23.
//

import SwiftUI

struct TTTBox: View {
    @StateObject var viewModel: ViewModel
    internal let inspection = Inspection<Self>() // 1 of 2 for ViewInspector
    
    var body: some View {
        VStack {
            Text(viewModel.value.rawValue)
                .frame(width: 100.0, height: 100.0)
                .background(Color.indigo)
                .cornerRadius(8)
                .font(.system(size: 72))
        }
        .onTapGesture {
            viewModel.boxTapped()
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) } // 2 of 2 for ViewInspector
    }
}

struct TTTBox_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack {
            TTTBox(viewModel: .init())
            TTTBox(viewModel: .init(value: .x))
            TTTBox(viewModel: .init(value: .o))
        }
        
    }
}
