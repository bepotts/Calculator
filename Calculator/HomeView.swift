//
//  HomeView.swift
//  Calculator
//
//  Created by Brandon Potts on 3/22/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

var total: Int = 0

struct HomeView: View {
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
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
                }
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
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
