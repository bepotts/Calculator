//
//  FifthRow.swift
//  Calculator
//
//  Created by Brandon Potts on 3/28/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

struct FifthRow: View {
    var body: some View {
        HStack {
            Button("AC", action: {
                total += 0
            }).background(Color.gray)
            Button("+/-", action: {
                total += 0
            }).background(Color.gray)
            Button("%", action: {
                total += 0
            }).background(Color.gray)
            Button("/", action: {
                total += 0
            }).background(Color.yellow)
        }.padding()
    }
}

struct FifthRow_Previews: PreviewProvider {
    static var previews: some View {
        FifthRow()
    }
}
