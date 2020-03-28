//
//  FirstRow.swift
//  Calculator
//
//  Created by Brandon Potts on 3/28/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

struct FirstRow: View {
    var body: some View {
        HStack{
            Button("0", action: {
                total += 0
            }).background(Color.gray)
            
            Button(".", action: {
                total = 2
            }).background(Color.gray)
            
            Button("=", action: {
                total = 1
            }).background(Color.yellow)
        }.padding()
    }
}

struct FirstRow_Previews: PreviewProvider {
    static var previews: some View {
        FirstRow()
    }
}
