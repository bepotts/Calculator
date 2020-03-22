//
//  OperationContainer.swift
//  Calculator
//
//  Created by Brandon Potts on 3/22/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

struct OperationContainer: View {
    let value: String
    var body: some View {
        Text(value)
    }
}

struct OperationContainer_Previews: PreviewProvider {
    static var previews: some View {
        OperationContainer(value: "This is a string")
    }
}
