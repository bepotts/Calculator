//
//  HomeView.swift
//  Calculator
//
//  Created by Brandon Potts on 3/22/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI

var total: Int = 0

let buttons = [
    ["C", "+/-", "%", "X"],
    ["7", "8", "9", "x"],
    ["4", "5", "6", "-"],
    ["1", "2", "3", "+"],
    ["0", ".", "="],
]

struct HomeView: View {
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack {
                    Spacer()
                    Text(String(total))
                        .foregroundColor(Color.white)
                        .font(.system(size: 50))
                }
                
                ForEach(buttons, id: \.self){ buttonRow in
                    HStack{
                        ForEach(buttonRow, id: \.self){ currentButton in
                            Text(currentButton)
                                .foregroundColor(Color.white).frame(width: self.generateWidth(button: currentButton), height: 100).background(Color.orange).cornerRadius(75)
                        }
                    }
                }
                
            }.padding(.bottom)
        }
    }
    
    func generateWidth(button: String) -> CGFloat {
        if button == "0" {
            return 200
        }
        return 100
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

