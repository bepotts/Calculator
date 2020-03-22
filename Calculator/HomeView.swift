//
//  HomeView.swift
//  Calculator
//
//  Created by Brandon Potts on 3/22/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        HStack{
            NumericalContainer(value: 0)
            OperationContainer(value: ".")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
