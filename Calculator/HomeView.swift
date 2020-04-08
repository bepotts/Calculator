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

/// Determines whether the display  value should update at 10^0 or higher
var numStartFromBegining: Bool = true
/// Stores the value of the previous operation
var previousOp: String = ""
/// Stores the value of the previous pushed button
var previousButton: String = ""

/// Buttons that are light gray
let lightGrayButtons: [String] = ["C", "+/-", "%"]
/// Buttons that are orange
let orangeButtons: [String] = ["/", "x", "-", "+", "="]



extension Color {
    static let lightGray = Color(red: 0.6, green: 0.6, blue: 0.6)
    static let darkGray = Color(red: 0.2, green: 0.2, blue: 0.2)
}

extension Double {
    func truncate(maxDigits: Int = 2)-> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = maxDigits
        return formatter.string(from: self as NSNumber) ?? "error"
    }
}

/// Error enum that is used for when an unknown value is being processed
enum InputError: Error {
    case invalidInput(String)
}

struct HomeView: View {
    
    @EnvironmentObject var numObservable: NumObservable
    
    
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



