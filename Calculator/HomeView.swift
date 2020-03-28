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
                Text(String(total))
                    .foregroundColor(Color.white)
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
                }
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
                }
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
                }
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
