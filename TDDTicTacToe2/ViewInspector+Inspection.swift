//
//  ViewInspector+Inspection.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/5/23.
//

import Combine
import SwiftUI

internal final class Inspection<V> {
    let notice = PassthroughSubject<UInt, Never>()
    var callbacks = [UInt: (V) -> Void]()
    
    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}
