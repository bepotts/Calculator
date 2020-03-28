//
//  ForthRow.swift
//  Calculator
//
//  Created by Brandon Potts on 3/28/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

struct ForthRow: View {
    var body: some View {
        HStack {
            Button("7", action: {
                total += 7
            }).background(Color.gray)
            
            Button("8", action: {
                total += 1
            }).background(Color.gray)
            
            Button("9", action: {
                total += 1
            }).background(Color.gray)
            Button("x", action: {
                total = 30
            }).background(Color.yellow)
        }.padding()
    }
}

struct ForthRow_Previews: PreviewProvider {
    static var previews: some View {
        ForthRow()
    }
}
