//
//  ThirdRow.swift
//  Calculator
//
//  Created by Brandon Potts on 3/28/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

struct ThirdRow: View {
    var body: some View {
        HStack {
            Button("4", action: {
                total += 4
            }).background(Color.gray)
            
            Button("5", action: {
                total += 5
            }).background(Color.gray)
            
            Button("6", action: {
                total += 6
            }).background(Color.gray)
            Button("-", action: {
                total = 30
            }).background(Color.yellow)
        }.padding()
    }
}

struct ThirdRow_Previews: PreviewProvider {
    static var previews: some View {
        ThirdRow()
    }
}
