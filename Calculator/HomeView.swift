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
    let calcButtons: [[CalcButton]]
    
    init(){
        self.calcButtons = [
            [.init(label: "C", color: Color.lightGray), .init(label: "+/-", color: Color.lightGray), .init(label: "%", color: Color.lightGray), .init(label: "/", color: Color.orange) ],
            [.init(label: "7"), .init(label: "8"), .init(label: "9"), .init(label: "x", color: Color.orange)],
            [.init(label: "4"), .init(label: "5"), .init(label: "6"), .init(label: "-", color: Color.orange)],
            [.init(label: "1"), .init(label: "2"), .init(label: "3"), .init(label: "+", color: Color.orange)],
            [.init(label: "0"), .init(label: "0"), .init(label: "=", color: Color.orange) ]
        ]
    }
    
    
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
                
                ForEach(buttons, id: \.self){ buttonRow in
                    HStack{
                        ForEach(buttonRow, id: \.self){ currentButton in
                            Button(action: {
                                self.numObservable.updateOrOperationDelegate(buttonLabel: currentButton)
                            }, label: {
                                Text(currentButton)
                                    .foregroundColor(Color.white)
                                    .frame(width: self.generateWidth(buttonLabel: currentButton), height: 100)
                                    .background(self.colorSelector(buttonLabel: currentButton)).cornerRadius(75)
                            })
                        }
                    }
                }
                
            }.padding(.bottom)
        }
    }

    /**
     Returns the color of a button based on the value of buttonText
     - Parameter buttonText: label of the button
     - Returns: Color of the buttonLabel
     */
    func colorSelector(buttonLabel: String) -> Color{
        if lightGrayButtons.contains(buttonLabel){
            return Color.lightGray
        }
        if orangeButtons.contains(buttonLabel){
            return Color.orange
        }
        return Color.darkGray
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



