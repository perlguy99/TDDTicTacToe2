//
//  Alert+ViewModel.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/11/23.
//

import SwiftUI

extension Alert {
    struct ViewModel: Identifiable {
        let title: String
        let message: String
        let buttonText: String
        let buttonAction: (() -> Void)?
        
        var id: String { title + message + buttonText }
    }
}
