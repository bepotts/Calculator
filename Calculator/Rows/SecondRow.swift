//
//  SecondRow.swift
//  Calculator
//
//  Created by Brandon Potts on 3/28/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

struct SecondRow: View {
    var body: some View {
        HStack {
            Button("1", action: {
                total += 1
            }).background(Color.gray)
            
            Button("2", action: {
                total += 2
            }).background(Color.gray)
            
            Button("3", action: {
                total += 3
            }).background(Color.gray)
            
            Button("+", action: {
                total = 30
            }).background(Color.yellow)
        }.padding()
    }
}

struct SecondRow_Previews: PreviewProvider {
    static var previews: some View {
        SecondRow()
    }
}
