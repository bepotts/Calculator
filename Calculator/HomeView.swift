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

/// Observable class that encapsulates the values that our math is performed on
class NumObservable: ObservableObject {
    @Published var finalSolution: Double = Double(Int.min)
    @Published var displayVal: Double = 0
    
    func reset() -> Void {
        finalSolution = Double(Int.min)
        displayVal = 0
    }
}

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
                                self.updateOrOperationDelegate(buttonLabel: currentButton)
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
    
    /**
     Updates the display text or performs and operation, based on the given text
     - Parameter buttonLabel: label of the pressed button
     - Returns: Void
     */
    func updateOrOperationDelegate(buttonLabel: String) -> Void {
        let errorInt: Double = -1
        let convertedInt: Double = Double(buttonLabel) ?? errorInt
        
        if convertedInt == errorInt {
            // This is to ignore input from user that hit the same button over and over again
            if buttonLabel == previousButton  && buttonLabel != "+/-"{
                return
            }
            do {
                try self.operationDelegate(opLabel: buttonLabel)
            } catch {
                let errorMessage: String = "Operation Delegate recieved an input that it didn't know what to do with"
                fatalError(errorMessage)
            }
        } else {
            self.updateDisplayVal(clickedVal: convertedInt)
        }
        
        previousButton = buttonLabel
    }
    
    /**
     Updates the number being displayed. Called after a user hits a number button
     - Parameter clickedVal: the value of the button that was just clicked
     - Returns: Void
     */
    func updateDisplayVal(clickedVal: Double) -> Void {
        
        // Will be true when this is the first value the user punched in
        if numStartFromBegining {
            numObservable.displayVal = clickedVal
            numStartFromBegining = false
        } else {
            numObservable.displayVal = numObservable.displayVal * 10 + clickedVal
        }
    }
    
    /**
     Performs the "addition" operation
     - Returns: Void
     */
    func addOperation() -> Void {
        numObservable.finalSolution += numObservable.displayVal
    }
    
    /**
     Performs the "subtraction" operation
     - Returns: Void
     */
    func subtractOperation() -> Void {
        numObservable.finalSolution -= numObservable.displayVal
    }
    
    /**
     Peforms the "division" operation
     - Returns: Void
     */
    func divideOperation() -> Void {
        numObservable.finalSolution /= numObservable.displayVal
    }
    
    /**
     Performs the "multiplication" operation
     - Returns: Void
     */
    func multiplyOperation() -> Void {
        numObservable.finalSolution *= numObservable.displayVal
    }
    
    /**
     Performs the "percent" operation.
     This changes the displayed value to an equivalent percentage value
     - Returns: Void
     */
    func percentOperation() -> Void {
        numObservable.displayVal /= 100
    }
    
    /**
     Performs the "clear" operation
     - Returns: Void
     */
    func clearOperation() -> Void {
        numStartFromBegining = true
        numObservable.reset()
        previousOp = ""
    }
    
    /**
     Performs the "equals" operation.
     - Returns: Void
     */
    func equalsOperation() -> Void {
        do {
            try operationDelegate(opLabel: previousOp)
        } catch {
            let errorMessage: String = "Operation Delegate recieved an operation that it didn't know what to do with"
            fatalError(errorMessage)
        }
        print("This is the solution after the operation: \(numObservable.finalSolution)")
        numObservable.displayVal = numObservable.finalSolution
        numObservable.finalSolution = Double(Int.min)
        numStartFromBegining = true
        previousOp = "="
        print("Equals operation")
    }
    
    /**
     Performs the change sign operation on the displayed value
     - Returns: Void
     */
    func changeSignOperation() -> Void {
        
        if numObservable.displayVal > 0 {
            numObservable.displayVal = 0 - numObservable.displayVal
        } else {
            numObservable.displayVal = abs(numObservable.displayVal)
        }
    }
    
    /**
     Accepts an operation label an executes the correspoding operation.
     - Parameter opLabel: label of the operation
     - Returns: Void
     - Throws: InputError.invalidInput
     */
    func operationDelegate(opLabel: String) throws ->  Void {
        print("Inside the operation delgate function")
        
        if opLabel == "C" {
            self.clearOperation()
            return
        }
        
        // Will be true when the user is trying to use the previous solution as the basis for a new equation
        if previousOp == "="  && opLabel != "="{
            numObservable.finalSolution = numObservable.displayVal
            previousOp = opLabel
            return
            // Will be true if the user has not entered a value and hit an operation
        } else if numObservable.finalSolution == Double(Int.min) && numObservable.displayVal == 0 {
            return
        }
        
        switch opLabel {
        case "+/-":
            self.changeSignOperation()
        case "%":
            print("We are about to run the percent op")
            self.percentOperation()
        case "=":
            equalsOperation()
        // Default triggers when doing a math operation
        default:
            print("Looks like we're performing a mathematical operation")
            previousOp = opLabel
            numStartFromBegining = true
            // Will be true when the user input the first number in an operation
            if numObservable.finalSolution == Double(Int.min) {
                numObservable.finalSolution = numObservable.displayVal
            } else if opLabel == "+"{
                self.addOperation()
            } else if opLabel == "-" {
                self.subtractOperation()
            } else if opLabel == "/" {
                self.divideOperation()
            } else if opLabel == "x" {
                self.multiplyOperation()
            } else {
                throw InputError.invalidInput(opLabel)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(NumObservable())
    }
}



