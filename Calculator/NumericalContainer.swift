//
//  NumericalContainer.swift
//  Calculator
//
//  Created by Brandon Potts on 3/22/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

struct NumericalContainer: View {
    let value: Int
    
    var body: some View {
        Text(String(value))
    }
}

struct NumericalContainer_Previews: PreviewProvider {
    static var previews: some View {
        NumericalContainer(value: 5)
    }
}
