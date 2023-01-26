//
//  ViewInspectorTest.swift
//  TDDTicTacToe2
//
//  Created by Brent Michalski on 1/5/23.
//

import SwiftUI

struct ViewInspectorTest: View {
    @State var flag: Bool = false
//    internal let inspection = Inspection<Self>()
    
    var body: some View {
        Button(action: {
            self.flag.toggle()
        }, label: { Text(flag ? "True" : "False") })
//        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

struct ViewInspectorTest_Previews: PreviewProvider {
    static var previews: some View {
        ViewInspectorTest()
    }
}
