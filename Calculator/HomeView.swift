//
//  HomeView.swift
//  Calculator
//
//  Created by Brandon Potts on 3/22/20.
//  Copyright © 2020 Brandon Potts. All rights reserved.
//

import SwiftUI


/// Represents the layout of the calculator buttons
let buttons: [[String]] = [
    ["C", "+/-", "%", "/"],
    ["7", "8", "9", "x"],
    ["4", "5", "6", "-"],
    ["1", "2", "3", "+"],
    ["0", ".", "="],
]

/// Buttons that are light gray
let lightGrayButtons: [String] = ["C", "+/-", "%"]
/// Buttons that are orange
let orangeButtons: [String] = ["/", "x", "-", "+", "="]


/// Error enum that is used for when an unknown value is being processed
enum InputError: Error {
    case invalidInput(String)
}

struct HomeView: View {
    
    @EnvironmentObject var numObservable: NumObservable
    var calcButtons: [[CalcButton]] = [
        [.init(label: "C"), .init(label: "+/-"),
         .init(label: "%"), .init(label: "/") ],
        [.init(label: "7"), .init(label: "8"), .init(label: "9"), .init(label: "x")],
        [.init(label: "4"), .init(label: "5"), .init(label: "6"), .init(label: "-")],
        [.init(label: "1"), .init(label: "2"), .init(label: "3"), .init(label: "+")],
        [.init(label: "0"), .init(label: "."), .init(label: "=") ]
    ]
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack {
                    Spacer()
                    Text(numObservable.displayVal.truncate(maxDigits: 8))
                        .foregroundColor(Color.white)
                        .font(.system(size: 50))
                }
                
                ForEach(self.calcButtons, id: \.self){ buttonRow in
                    HStack{
                        ForEach(buttonRow, id: \.self){ currentButton in
                            CalcButtonView(newCalcButton: currentButton)
                        }
                    }
                }
                
            }.padding(.bottom)
        }
    }
    /**
     Returns the width of a button based on that button's label
     - Parameter buttonLabel: label of the button
     - Returns: width of the given button
     */
    func generateWidth(buttonLabel: String) -> CGFloat {
        if buttonLabel == "0" {
            return 200
        }
        return 100
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(NumObservable())
    }
}



