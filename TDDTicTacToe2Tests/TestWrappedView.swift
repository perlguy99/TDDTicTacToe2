//
//  TestWrappedView.swift
//  TDDTicTacToe2Tests
//
//  Created by Brent Michalski on 1/24/23.
//

@testable import TDDTicTacToe2
import SwiftUI
import ViewInspector

public let TEST_WRAPPED_ID: String = "wrapped"

//struct TestWrapperView<Wrapped: View>: View {
//    internal let inspection = Inspection<Self>()
//    var wrapped: Wrapped
//    
//    init(wrapped: Wrapped) {
//        self.wrapped = wrapped
//    }
//    
//    var body: some View {
//        wrapped
//            .id(TEST_WRAPPED_ID)
//            .onReceive(inspection.notice) {
//                self.inspection.visit(self, $0)
//            }
//    }
//}
//
//extension TestWrapperView: Inspectable {}
